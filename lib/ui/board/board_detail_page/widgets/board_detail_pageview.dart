import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/board_dto.dart';
import 'package:flutter/material.dart';

class BoardDetailPageView extends StatelessWidget {
  const BoardDetailPageView({
    super.key,
    required this.boardDTO,
  });

  final BoardDTO boardDTO;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: 300,
      child: PageView.builder(
        controller: new PageController(viewportFraction: 0.93),
        pageSnapping: true,
        itemCount: boardDTO.photoList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Stack(
              alignment: const Alignment(0.9, 0.9),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "$imageURL${boardDTO.photoList[index]}",
                    height: 300,
                    width: sizeGetScreenWidth(context),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                  child: Text(
                    "${index + 1} / ${boardDTO.photoList.length}",
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
