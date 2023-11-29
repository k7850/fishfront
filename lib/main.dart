import 'package:fishfront/_core/constants/move.dart';
import 'package:fishfront/_core/constants/theme.dart';
import 'package:fishfront/ui/auth/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await initializeDateFormatting();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'FISH',
      home: LoginPage(),
      initialRoute: "/login",
      routes: getRouters(),
      theme: theme(),
    );
  }
}
