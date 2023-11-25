import 'package:fishfront/ui/auth/join_page/join_body.dart';
import 'package:fishfront/ui/auth/join_page/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JoinBody(),
    );
  }
}
