import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/data/dto/comment_dto.dart';
import 'package:fishfront/ui/_common_widgets/build_time.dart';
import 'package:flutter/material.dart';

class BoardDetailComment extends StatelessWidget {
  const BoardDetailComment({
    super.key,
    required this.commentDTOList,
  });

  final List<CommentDTO> commentDTOList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          // Text("댓글 ${commentDTOList.length}", style: TextStyle(fontSize: 17, color: Colors.grey[600])),
          // const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(commentDTOList[index].username, style: TextStyle(fontSize: 17, color: Colors.grey[600])),
                      const Spacer(),
                      Text(buildTime(commentDTOList[index].createdAt), style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text("${commentDTOList[index].text}"),
                ],
              );
            },
            itemCount: commentDTOList.length,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
