import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:flutter/material.dart';

class JoinFormContainerTop extends StatelessWidget {
  TextEditingController _email;
  TextEditingController _password;

  JoinFormContainerTop(
    this._email,
    this._password,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              return validateEmail()(value);
            },
            controller: _email,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: "아이디@naver.com",
              hintText: "example@example.com",
            ),
          ),
          TextFormField(
            validator: (value) {
              return validatePassword()(value);
            },
            controller: _password,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: "비밀번호",
              hintText: "********",
            ),
            obscureText: true, // 비밀번호 필드로 설정
          ),
        ],
      ),
    );
  }
}
