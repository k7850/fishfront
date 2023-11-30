import 'package:flutter/material.dart';

class MyCheckbox extends StatelessWidget {
  const MyCheckbox({
    super.key,
    required this.str,
    required this.isChecked,
  });

  final String str;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isChecked ? const Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
        const SizedBox(width: 5),
        Text(
          str,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: isChecked ? Colors.black : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
