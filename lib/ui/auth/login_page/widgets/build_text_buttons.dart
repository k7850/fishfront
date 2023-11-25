import 'package:flutter/material.dart';

// TODO : 아이디 찾기 페이지 제작 및 연결
TextButton buildTextButtonFindId(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, "/join");
    },
    child: Text("아이디 찾기"),
  );
}

// TODO : 비밀번호 찾기 페이지 제작 및 연결
TextButton buildTextButtonPassword(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, "/join");
    },
    child: Text("비밀번호 찾기"),
  );
}

TextButton buildTextButtonJoin(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, "/join");
    },
    child: Text("회원가입"),
  );
}

TextButton buildTextButtonLogin(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    },
    child: Text("로그인"),
  );
}
