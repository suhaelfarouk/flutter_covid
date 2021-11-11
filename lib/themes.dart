import 'package:flutter/material.dart';
import 'package:flutter_covid/datasource.dart';

var lightThemeData = new ThemeData(
  primaryColor: primaryBlack,
  textTheme: new TextTheme(button: TextStyle(color: Colors.white70)),
  brightness: Brightness.light,
  fontFamily: 'Gilroy',
  scaffoldBackgroundColor: Colors.white,
);

var darkThemeData = new ThemeData(
  primaryColor: primaryBlack,
  textTheme: new TextTheme(button: TextStyle(color: Colors.black54)),
  brightness: Brightness.dark,
  fontFamily: 'Gilroy',
  scaffoldBackgroundColor: Colors.blueGrey[900],
);
