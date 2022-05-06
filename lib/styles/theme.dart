import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/save_data/const.dart';


ThemeData lightMode () => ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    actionsIconTheme: IconThemeData(
        color: Colors.black
    ),
    titleTextStyle: TextStyle(color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: "jannah",
      fontSize: 23,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),),
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    border:OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),),
    contentPadding: EdgeInsetsDirectional.only(top: 5,),
    hintStyle: TextStyle(color: Colors.black,fontSize: 16),
  ),
  textTheme: TextTheme(
    caption:  TextStyle(color: Colors.black,
          fontWeight: FontWeight.w400,
          fontFamily: "jannah",
          fontSize: 14),
      bodyText1: TextStyle(color: Colors.black,
          fontWeight: FontWeight.w400,
          fontFamily: "jannah",
          fontSize: 18)),
  );
ThemeData darkMode () =>   ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor:Colors.black,
    elevation: 0,
    actionsIconTheme: IconThemeData(
        color: Colors.white
    ),
    titleTextStyle: TextStyle(color: Colors.white,
    fontFamily: "jannah",
      fontWeight: FontWeight.bold,
      fontSize: 23,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: HexColor('#212121'),
      statusBarIconBrightness: Brightness.light,
    ),),
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor:HexColor('#181818'),
  inputDecorationTheme: InputDecorationTheme(fillColor: Colors.yellow,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    contentPadding: EdgeInsetsDirectional.only(top: 5,),
    hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
  ),
  textTheme: TextTheme(
    caption:  TextStyle(color: Colors.grey,
          fontWeight: FontWeight.w200,
          fontFamily: "jannah",
          fontSize: 14),
      bodyText1: TextStyle(color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: "jannah",
          fontSize: 18)),
  iconTheme: IconThemeData(color: Colors.white),
  primaryIconTheme: IconThemeData(color: Colors.white),

);