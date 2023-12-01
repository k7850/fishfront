import 'package:fishfront/_core/constants/my_color.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: "Giants",
    primarySwatch: Colors.blue,
    primaryColor: CommonColors.white,
    // canvasColor: Colors.transparent,
    // scaffoldBackgroundColor: Color.fromRGBO(200, 200, 200, 1),
    dividerColor: Colors.black26,
    brightness: Brightness.light, // 앱의 기본 밝기 설정
    textTheme: TextTheme(
        // bodyMedium: TextStyle(fontSize: 15), // 기본 텍스트
        // bodySmall: TextStyle(fontSize: 10, color: Colors.grey[600], fontFamily: "JamsilRegular"),
        // displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        // displayMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
        ),
    appBarTheme: AppBarTheme(),
  );
}
