import 'package:flutter/material.dart';
import './colors.dart';

class CustomStyles {
  // TextStyle fontWhite

  // Color color1 = Color.fromRGBO(100, 174, 160, 1);
  // Color color2 = Color.fromRGBO(22, 153, 103, 1);
  Color color1 = Color(0xff16a596);
  Color color2 = Color(0xff4db6ac);
  Color color3 = Color(0xffcae4e5);
  ThemeData customThemeData() => ThemeData(
        brightness: Brightness.light,
        // primarySwatch: MaterialColor(Color(0xff16a596).value, Color(0xff16a596).value),
        primaryColor: MyColors.black[500],
        backgroundColor: color1,
        primaryColorBrightness: Brightness.light,
        accentColorBrightness: Brightness.light,
        textTheme: TextTheme(
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline4: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            button: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.all(10.0),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintStyle: TextStyle(color: Colors.grey)),
      );
}
