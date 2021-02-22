import 'package:flutter_appauth/flutter_appauth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parkrun_app/models/user.dart';

class OpenIDConnect {
  FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  var redirectUrl = 'com.flutter.lotusproject://callback';
  var clientId = 'ba08dd00-484a-0139-b563-06351d701be3184317';
  var issuerUrl = "https://openid-connect.onelogin.com/oidc";

  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
    final url = 'https://openid-connect.onelogin.com/oidc/me';
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future initializeToken() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    print(
        'initialize app has storedRefreshToken? :${storedRefreshToken != null}');
    if (storedRefreshToken == null) return;
    try {
      final response = await appAuth.token(TokenRequest(
        clientId,
        redirectUrl,
        issuer: issuerUrl,
        refreshToken: storedRefreshToken,
      ));
      final profile = await getUserDetails(response.accessToken);
      var user = User.fromJson(profile);
      print('profile ${user.firstname} ${user.id} ${user.email}');
      secureStorage.write(key: 'refresh_token', value: response.refreshToken);
      secureStorage.write(key: 'access_token', value: response.accessToken);
      return true;
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      signOut();
      return false;
    }
  }

  Future signIn() async {
    try {
      final AuthorizationTokenResponse response =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUrl,
          issuer: issuerUrl,
          scopes: ['openid', 'profile'],
          promptValues: ['login'],
        ),
      );
      // final tokenJSON = parseIdToken(response.idToken);
      final profile = await getUserDetails(response.accessToken);
      var user = User.fromJson(profile);
      // print('tokenID JSON: $tokenJSON');
      print('profile ${user.firstname} ${user.id} ${user.email}');
      secureStorage.write(key: 'refresh_token', value: response.refreshToken);
      secureStorage.write(key: 'access_token', value: response.accessToken);
      return true;
    } catch (e, s) {
      print('login error: $e - stack: $s');
      return false;
    }
  }

  Future signOut() async {
    print('signOut');
    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      var r = await http.post(
          'https://openid-connect.onelogin.com/oidc/token/revocation',
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'token': accessToken,
            'token_type_hint': 'access_token',
            'client_id': clientId
          });
      print('logout code: ${r.statusCode}');
      if (r.statusCode == 200) {
        await secureStorage.delete(key: 'refresh_token');
        await secureStorage.delete(key: 'access_token');
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
