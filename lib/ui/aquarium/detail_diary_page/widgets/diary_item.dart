import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/diary_dto.dart';
import 'package:fishfront/ui/aquarium/main_page/widgets/aquarium_card.dart';
import 'package:flutter/material.dart';

class DiaryItem extends StatelessWidget {
  DiaryDTO diaryDTO;

  DiaryItem({
    required this.diaryDTO,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      decoration: BoxDecoration(color: idColorMage(diaryDTO.id), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            "${diaryDTO.createdAt.year}년 ${diaryDTO.createdAt.month}월 ${diaryDTO.createdAt.day}일",
            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
          ),
          diaryDTO.title != null && diaryDTO.title!.isEmpty
              ? const SizedBox()
              : Container(
                  alignment: const Alignment(-1, 0),
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("${diaryDTO.title}", style: const TextStyle(fontSize: 20, color: Colors.black, fontFamily: "Giants")),
                ),
          diaryDTO.text != null && diaryDTO.text!.isEmpty
              ? const SizedBox()
              : Container(
                  alignment: const Alignment(-1, 0),
                  child: Text("${diaryDTO.text}", style: TextStyle(color: Colors.grey[600])),
                ),
          diaryDTO.photo == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "$imageURL${diaryDTO.photo}",
                      width: sizeGetScreenWidth(context),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/diary.png",
                          width: sizeGetScreenWidth(context),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
