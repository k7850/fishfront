import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:flutter/material.dart';

class JoinFormContainerMiddle extends StatelessWidget {
  TextEditingController _username;
  TextEditingController _birthday;
  TextEditingController _tel;

  JoinFormContainerMiddle(this._username, this._birthday, this._tel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF8E8E8E)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              return validateUsername()(value);
            },
            controller: _username,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: "이름",
              hintText: "홍길동",
            ),
          ),
          TextFormField(
            controller: _birthday,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.calendar_today),
              labelText: "생년월일 8자리",
              hintText: "1997-05-31",
            ),
          ),
          TextFormField(
            controller: _tel,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              labelText: "휴대전화번호",
              hintText: "010-0000-0000",
            ),
          ),
        ],
      ),
    );
  }
}
