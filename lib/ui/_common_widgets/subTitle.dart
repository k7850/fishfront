import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({
    super.key,
    required this.subTitle,
    this.top = 13,
    this.bottom = 2,
  });

  final String subTitle;
  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top, bottom: bottom),
      alignment: const Alignment(-1, 0),
      child: Text(subTitle, style: TextStyle(color: Colors.grey[600])),
    );
  }
}
