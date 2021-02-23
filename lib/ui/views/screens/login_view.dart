import 'package:flutter/material.dart';
import 'package:parkrun_app/packages.dart';
import 'package:parkrun_app/core/services/openid_connect.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // AuthModel _authFn = AuthModel();
  bool isSubmit = false;
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  OpenIDConnect _auth = OpenIDConnect();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    // final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    // print(storedRefreshToken);
    // if (storedRefreshToken != null) {
    //   EasyLoading.show(status: 'loading...');
    //   var res = await _auth.initializeToken();
    //   if (res) EasyLoading.showSuccess('Sign in successfully');
    // }
  }

  // _login({String username, String password}) async {
  _login() async {
    // _onelogin();
    EasyLoading.show(status: 'loading...');
    bool res = await _auth.signIn();
    if (res) {
      EasyLoading.showSuccess('Sign in successfully');
    } else
      EasyLoading.showError('Sign in failed');
  }

  void _logout() async {
    print('logoutAction fn');
    EasyLoading.show(status: 'loading...');
    await _auth.signOut();
    EasyLoading.showSuccess('Sign in successfully');
  }

  _demologin() async {
    print('_demologin');
    EasyLoading.show(status: 'loading...');
    await Future.delayed(Duration(seconds: 1));
    try {
      EasyLoading.showSuccess('Sign in successfully');

      Navigator.pushNamed(context, 'home');
    } catch (e) {
      EasyLoading.showError('Sign in failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    var styles = Theme.of(context);

    return Scaffold(
      backgroundColor: styles.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
              width: 240,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
            ),
            TextFormField(
              controller: _controllerUsername,
              decoration: InputDecoration(hintText: "Username"),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _controllerPassword,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              minWidth: 120,
              child: Text(
                'Try Demo',
                style: styles.textTheme.button.copyWith(color: Colors.white),
              ),
              onPressed: () => _demologin(),
            ),
            MaterialButton(
              minWidth: 120,
              child: Text(
                'Logout',
                style: styles.textTheme.button.copyWith(color: Colors.white),
              ),
              onPressed: () => _logout(),
            ),
          ],
        ),
      ),
    );
  }
}
