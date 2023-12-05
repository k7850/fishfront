import 'package:fishfront/_core/constants/size.dart';
import 'package:flutter/material.dart';

class BoardDetailEmoticon extends StatelessWidget {
  const BoardDetailEmoticon({
    super.key,
    required this.text,
    required this.isMyEmoticon,
  });

  final String text;
  final bool isMyEmoticon;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.14),
      padding: const EdgeInsets.symmetric(vertical: 2),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(color: isMyEmoticon ? Colors.blue : Colors.grey[400], borderRadius: BorderRadius.circular(5)),
      child: Text(" $text ", style: const TextStyle(fontSize: 17)),
    );
  }
}
