import 'package:fishfront/_core/constants/my_color.dart';
import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomSubmitButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: TextButton(
        child: Text(text, style: TextStyle(color: Colors.white)),
        style: TextButton.styleFrom(backgroundColor: CommonColors.green),
        onPressed: onPressed,
      ),
    );
  }
}
