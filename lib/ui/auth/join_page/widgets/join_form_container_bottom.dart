import 'package:fishfront/ui/auth/join_page/widgets/join_my_expansion_tile.dart';
import 'package:flutter/material.dart';

class JoinBuildContainerBottom extends StatelessWidget {
  const JoinBuildContainerBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: MyExpansionTile(
        title: "인증 약관 전체 동의",
        content: [
          Text("약관 내용 1"),
          Text("약관 내용 2"),
          Text("약관 내용 3"),
          Text("약관 내용 4"),
          Text("약관 내용 5"),
        ],
      ),
    );
  }
}
