import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:fishfront/data/DTO/user_request.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/ui/auth/login_page/widgets/custom_login_text_form_field.dart';
import 'package:fishfront/ui/_common_widgets/custom_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController(text: "ssar@naver.com");
  final _password = TextEditingController(text: "1234");

  LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("로그인폼으로옴");
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Row(children: [Text("PC 키보드 보기"), Icon(Icons.toggle_on)]),
          CustomLoginTextFormWidget(
            text: "아이디",
            iconData: Icons.person,
            obscureText: false,
            funValidator: validateEmail(),
            controller: _email,
          ),
          const SizedBox(height: sizeM10),
          CustomLoginTextFormWidget(
            text: "비밀번호",
            iconData: Icons.lock,
            obscureText: true,
            funValidator: validatePassword(),
            controller: _password,
          ),
          const SizedBox(height: sizeXL50),
          CustomSubmitButton(
            text: "로그인",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                LoginReqDTO loginReqDTO = LoginReqDTO(
                  email: _email.text,
                  password: _password.text,
                );
                print(_email.text);
                print(_password.text);
                SessionUser user = ref.read(sessionProvider);
                user.login(loginReqDTO);
              }
            },
          ),
        ],
      ),
    );
  }
}
