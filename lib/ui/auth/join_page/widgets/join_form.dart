import 'package:fishfront/_core/constants/my_color.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/DTO/user_request.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/ui/_common_widgets/custom_submit_button.dart';
import 'package:fishfront/ui/auth/join_page/widgets/join_form_container_bottom.dart';
import 'package:fishfront/ui/auth/join_page/widgets/join_form_container_middle.dart';
import 'package:fishfront/ui/auth/join_page/widgets/join_form_container_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();
  final _birthday = TextEditingController();
  final _tel = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          JoinFormContainerTop(_email, _password),
          SizedBox(height: sizeL20),
          JoinFormContainerMiddle(_username, _birthday, _tel),
          SizedBox(height: sizeL20),
          JoinBuildContainerBottom(),
          SizedBox(height: sizeL20),
          CustomSubmitButton(
            text: "회원가입",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print("회원가입 버튼 누름");
                JoinReqDTO joinReqDTO = JoinReqDTO(
                  username: _username.text,
                  password: _password.text,
                  email: _email.text,
                  // email: "${_email.text}@naver.com",
                );
                ref.read(sessionProvider).join(joinReqDTO);
              }
            },
          ),
        ],
      ),
    );
  }
}
