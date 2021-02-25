import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ServerAPI {
  String serverURL = '';
  var client = new http.Client();

  Future signIn(email, password) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      print(user);
      return user;
    } catch (e) {
      print('ERR $e');
    }
  }

  Future signOut() async {
    try {
      final response = await _auth.signOut();
      return response;
    } catch (e) {
      print('ERR $e');
    }
  }

  Future currentUser() async {
    try {
      final User user = _auth.currentUser;
      return user;
    } catch (e) {
      print('ERR $e');
    }
  }

  Future getEventsList() async {
    print('getEventsList');
    var userId = "5fc34ec5baa3a50789afa5ee";
    var urlx = 'https://asia-southeast2-parkrun-th.cloudfunctions.net/api';
    // await Future.delayed(Duration(seconds: 1));
    // return List<String>.generate(10, (i) => i.toString().padLeft(4, '0'));
    Map<String, String> headers = {"Content-type": "application/json"};
    var bodyAuth = jsonEncode({
      "query":
          "query(\$userId: MongoID!) {\ngetRaceVolunteer(userId:\$userId){\nname\nslug\nstartTime\nendTime\nevent{\nimage\n}\n}\n}",
      "variables": {"userId": userId}
    }).toString();
    print('prreee');
    var response = await client.post(urlx, headers: headers, body: bodyAuth);
    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        var body = await json.decode(response.body)['data'];
        print(body);
        return {'status': body != null, 'body': body};
      } catch (e) {
        print(e);
        print(response.body);
        return {'status': false, 'body': null};
      }
    } else
      return {'status': false, 'body': null};
  }

  Future uploadRunnerRecordEach() async {}

  Future uploadRunnerRecordAll() async {}
}
