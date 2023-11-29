import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/ui/auth/join_page/widgets/join_form.dart';
import 'package:fishfront/ui/auth/login_page/widgets/build_text_buttons.dart';
import 'package:flutter/material.dart';

class JoinBody extends StatelessWidget {
  const JoinBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(sizePadding20),
      child: ListView(
        children: [
          SizedBox(height: sizeL20),
          SizedBox(width: 100, height: 100, child: Image.asset("assets/fish.png")),
          SizedBox(height: sizeL20),
          JoinForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextButtonFindId(context),
              buildTextButtonPassword(context),
              buildTextButtonLogin(context),
            ],
          )
        ],
      ),
    );
  }
}
