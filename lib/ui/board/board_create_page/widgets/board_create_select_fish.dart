import 'package:flutter/material.dart';

import '../../../../data/dto/fish_dto.dart';
import 'board_create_selectfish.dart';

class BoardCreateSelectFish extends StatelessWidget {
  const BoardCreateSelectFish({
    super.key,
    required this.fishDTO,
  });

  final FishDTO? fishDTO;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return const SelectFish();
          },
        );
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color.fromRGBO(210, 210, 210, 1)),
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 5),
            child: Text(fishDTO == null ? "" : fishDTO!.name, style: const TextStyle(fontSize: 17)),
          ),
        ],
      ),
    );
  }
}
