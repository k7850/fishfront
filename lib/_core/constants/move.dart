import 'package:fishfront/ui/auth/join_page/join_page.dart';
import 'package:fishfront/ui/auth/login_page/login_page.dart';
import 'package:fishfront/ui/book/book_page/book_page.dart';
import 'package:fishfront/ui/aquarium/main_page/main_page.dart';
import 'package:flutter/material.dart';

// Map<String, Widget Function(BuildContext)> 를 반환하는 함수
Map<String, Widget Function(BuildContext)> getRouters() {
  return {
    "/join": (context) => JoinPage(),
    "/login": (context) => LoginPage(),
    "/main": (context) => MainPage(),
    "/book": (context) => BookPage(),
  };
}
