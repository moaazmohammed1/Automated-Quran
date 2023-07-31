import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Color(0x1A484848)

const defaultColor = Color(0xFF2A722F);
const greyColor = Color(0xFF616161);
const grey100Color = Color(0xFFBBBBBB);
const redColor = Color(0xFFB3271D);
const blue2Color = Color(0xFF1D2CB3);
const blueColor = Color(0xFF4267B2);
// const blue2Color = Color(0xF60337A7);
// const redColor = Color(0xFF92221A);

ThemeData lightMode = ThemeData(
  primarySwatch: const MaterialColor(
    0xFF880E4F,
    {
      50: Color.fromRGBO(36, 82, 38, .1),
      100: Color.fromRGBO(36, 82, 38, .2),
      200: Color.fromRGBO(36, 82, 38, .3),
      300: Color.fromRGBO(36, 82, 38, .4),
      400: Color.fromRGBO(36, 82, 38, .5),
      500: Color.fromRGBO(36, 82, 38, .6),
      600: Color.fromRGBO(36, 82, 38, .7),
      700: Color.fromRGBO(36, 82, 38, .8),
      800: Color.fromRGBO(36, 82, 38, .9),
      900: Color.fromRGBO(36, 82, 38, 1),
    },
  ),
  primaryColor: defaultColor,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Tajawal',
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    subtitle1: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Tajawal',
      color: Colors.black,
      // color: defaultColor,
    ),
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: greyColor,
      fontFamily: 'Tajawal',
    ),
    bodyText2: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      color: defaultColor,
      fontFamily: 'Tajawal',
    ),
  ),
  fontFamily: 'Tajawal',
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    floatingLabelStyle: TextStyle(
      color: defaultColor,
    ),
  ),
);
