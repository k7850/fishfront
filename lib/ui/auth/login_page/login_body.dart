import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/ui/auth/login_page/widgets/build_text_buttons.dart';
import 'package:fishfront/ui/auth/login_page/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginBody extends ConsumerWidget {
  // final _formKey = GlobalKey<FormState>();
  // final _email = TextEditingController(text: "ssar@naver.com");
  // final _password = TextEditingController(text: "1234");

  LoginBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(sizePaddingLR17),
      child: ListView(
        children: [
          const SizedBox(height: sizeL20),
          SizedBox(width: 40, height: 40, child: Image.asset("assets/main.png")),
          const SizedBox(height: sizeL20),
          LoginForm(),
          const SizedBox(height: sizeL20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextButtonFindId(context),
              buildTextButtonPassword(context),
              buildTextButtonJoin(context),
            ],
          ),
        ],
      ),
    );
  }
}
