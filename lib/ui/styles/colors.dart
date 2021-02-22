/**
 * Creating custom color palettes is part of creating a custom app. The idea is to create
 * your class of custom colors, in this case `MyColors` and then create a `ThemeData`
 * object with those colors you just defined.
 *
 * Resource:
 * A good resource would be this website: http://mcg.mbitson.com/
 * You simply need to put in the colour you wish to use, and it will generate all shades
 * for you. Your primary colour will be the `500` value.
 *
 * Colour Creation:
 * In order to create the custom colours you need to create a `Map<int, Color>` object
 * which will have all the shade values. `const Color(0xFF...)` will be how you create
 * the colours. The six character hex code is what follows. If you wanted the colour
 * #114488 or #D39090 as primary colours in your theme, then you would have
 * `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
 *
 * Usage:
 * In order to use this newly created theme or even the colours in it, you would just
 * `import` this file in your project, anywhere you needed it.
 * `import 'path/to/theme.dart';`
 */

import 'package:flutter/material.dart';

final ThemeData customTheme = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: MaterialColor(MyColors.black[50].value, MyColors.black),
  primaryColor: MyColors.black[500],
  primaryColorBrightness: Brightness.light,
  // accentColor: MyColors.green[500],
  accentColorBrightness: Brightness.light
);
  
class MyColors {
  // static const cc = [50,100,200,300,400,500,600,700,800,900];

  MyColors._(); // this basically makes it so you can instantiate this class
  static Map<int, Color> black = <int, Color> {
    50: Color.fromRGBO(247,247,247,1),
    100: Color.fromRGBO(238,238,238,1),
    200: Color.fromRGBO(226,226,226,1),
    300: Color.fromRGBO(208,208,208,1),
    400: Color.fromRGBO(171,171,171,1),
    500: Color.fromRGBO(138,138,138,1),
    600: Color.fromRGBO(99,99,99,1),
    700: Color.fromRGBO(80,80,80,1),
    800: Color.fromRGBO(50,50,50,1),
    900: Color.fromRGBO(18,18,18,1)
  };
  
  // static const Map<int, Color> green = const <int, Color> {
  //   50: const Color(/* some hex code */),
  //   100: const Color(/* some hex code */),
  //   200: const Color(/* some hex code */),
  //   300: const Color(/* some hex code */),
  //   400: const Color(/* some hex code */),
  //   500: const Color(/* some hex code */),
  //   600: const Color(/* some hex code */),
  //   700: const Color(/* some hex code */),
  //   800: const Color(/* some hex code */),
  //   900: const Color(/* some hex code */)
  // };
}