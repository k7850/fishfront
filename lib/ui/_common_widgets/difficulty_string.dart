import 'package:flutter/material.dart';

class DifficultyString extends StatelessWidget {
  const DifficultyString({
    super.key,
    required this.difficulty,
  });

  final int difficulty;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: "사육 난이도 : ",
        style: const TextStyle(color: Colors.black, fontFamily: "Giants"),
        children: [
          TextSpan(
            text: difficulty == 1
                ? "아주 쉬움"
                : difficulty == 2
                    ? "쉬움"
                    : difficulty == 3
                        ? "보통"
                        : difficulty == 4
                            ? "어려움"
                            : "아주 어려움",
            style: TextStyle(
                fontFamily: "Giants",
                fontSize: 15,
                color: difficulty == 1
                    ? Colors.green
                    : difficulty == 2
                        ? Colors.blue
                        : difficulty == 3
                            ? Colors.black
                            : difficulty == 4
                                ? Colors.orange
                                : Colors.red[800]),
          ),
        ],
      ),
    );
  }
}
