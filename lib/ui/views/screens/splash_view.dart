import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashView extends StatelessWidget {
  final Widget afterView;
  SplashView(this.afterView);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
          seconds: 2,
          navigateAfterSeconds: afterView,
          title: Text(
            '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white),
          ),
          image: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.cover,
          ),
          backgroundColor: Color.fromRGBO(22, 153, 103, 1),
          styleTextUnderTheLoader: TextStyle(),
          photoSize: 100.0,
          onClick: () => print("Flutter Splash"),
          loaderColor: Colors.red),
    );
  }
}
