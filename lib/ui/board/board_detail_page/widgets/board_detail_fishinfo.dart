import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/ui/_common_widgets/difficulty_string.dart';
import 'package:flutter/material.dart';

import '../../../../_core/constants/enum.dart';
import '../../../../data/dto/fish_dto.dart';

class BoardDetailFishInfo extends StatefulWidget {
  const BoardDetailFishInfo({
    super.key,
    required this.fishDTO,
  });

  final FishDTO fishDTO;

  @override
  State<BoardDetailFishInfo> createState() => _BoardDetailFishInfoState();
}

class _BoardDetailFishInfoState extends State<BoardDetailFishInfo> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    if (isOpen == false) {
      return InkWell(
        onTap: () => setState(() => isOpen = !isOpen),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Center(child: Text("생물 정보 보기 ▼", style: TextStyle(fontSize: 18, color: Colors.grey[700]))),
            const SizedBox(height: 15),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          InkWell(
            onTap: () => setState(() => isOpen = !isOpen),
            child: Center(child: Text("생물 정보 ▲", style: TextStyle(fontSize: 18, color: Colors.grey[700]))),
          ),
          const SizedBox(height: 5),
          if (widget.fishDTO.fishClassEnum == FishClassEnum.FISH) Text("물고기", style: TextStyle(fontSize: 17, color: Colors.grey[700])),
          if (widget.fishDTO.fishClassEnum == FishClassEnum.OTHER) Text("기타 생물", style: TextStyle(fontSize: 17, color: Colors.grey[700])),
          if (widget.fishDTO.fishClassEnum == FishClassEnum.PLANT) Text("수초", style: TextStyle(fontSize: 17, color: Colors.grey[700])),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("${widget.fishDTO.name} ", style: const TextStyle(fontSize: 25)),
              Container(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  "${widget.fishDTO.quantity != null && widget.fishDTO.quantity != 0 ? "(x${widget.fishDTO.quantity}" : "(x1"}${widget.fishDTO.isMale == null ? ")" : widget.fishDTO.isMale! ? ", 수컷) " : ", 암컷) "}",
                  style: TextStyle(fontSize: 17, color: Colors.grey[700], fontFamily: "JamsilRegular"),
                ),
              ),
            ],
          ),
          if (widget.fishDTO.book != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "$imageURL${widget.fishDTO.book!.photo}",
                    width: sizeGetScreenWidth(context),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
                Text("${widget.fishDTO.book!.normalName}", style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 5),
                Text("${widget.fishDTO.book!.biologyName}", style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 5),
                DifficultyString(difficulty: widget.fishDTO.book!.difficulty ?? 1),
                const SizedBox(height: 15),
                Text("${widget.fishDTO.book!.text}", style: TextStyle(fontSize: 15, color: Colors.grey[600])),
              ],
            ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
