import 'package:flutter/material.dart';

class BoardCreateTextFormField extends StatelessWidget {
  BoardCreateTextFormField({
    super.key,
    required this.controller,
    required this.validate,
    this.maxLine = 1,
  });

  final TextEditingController controller;
  var validate;
  int maxLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
        filled: true,
        fillColor: Color.fromRGBO(210, 210, 210, 1),
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
      ),
      controller: controller,
      validator: validate,
    );
  }
}
