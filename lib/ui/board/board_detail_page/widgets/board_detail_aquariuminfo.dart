import 'package:flutter/material.dart';

import '../../../../_core/constants/enum.dart';
import '../../../../data/dto/aquarium_dto.dart';
import '../../../../data/dto/equipment_dto.dart';
import '../../../../data/dto/fish_dto.dart';

class BoardDetailAquariumInfo extends StatefulWidget {
  const BoardDetailAquariumInfo({
    super.key,
    required this.aquariumDTO,
  });

  final AquariumDTO aquariumDTO;

  @override
  State<BoardDetailAquariumInfo> createState() => _BoardDetailAquariumInfoState();
}

class _BoardDetailAquariumInfoState extends State<BoardDetailAquariumInfo> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    List<FishDTO> onlyFishList = [];
    List<FishDTO> onlyPlantList = [];
    List<FishDTO> onlyOtherList = [];

    for (var fishDTO in widget.aquariumDTO.fishDTOList) {
      if (fishDTO.fishClassEnum == FishClassEnum.OTHER) {
        onlyOtherList.add(fishDTO);
      } else if (fishDTO.fishClassEnum == FishClassEnum.PLANT) {
        onlyPlantList.add(fishDTO);
      } else {
        onlyFishList.add(fishDTO);
      }
    }
    if (isOpen == false) {
      return InkWell(
        onTap: () => setState(() => isOpen = !isOpen),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Center(child: Text("어항 정보 보기 ▼", style: TextStyle(fontSize: 18, color: Colors.grey[700]))),
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
            child: Center(child: Text("어항 정보 ▲", style: TextStyle(fontSize: 18, color: Colors.grey[700]))),
          ),
          const SizedBox(height: 5),
          Text(widget.aquariumDTO.isFreshWater ?? true ? "담수 어항" : "해수 어항", style: TextStyle(fontSize: 17, color: Colors.grey[700])),
          Text(" 길이 : ${widget.aquariumDTO.size?.split("/")[0] ?? "0"} cm"),
          Text(" 폭 : ${widget.aquariumDTO.size?.split("/")[1] ?? "0"} cm"),
          Text(" 높이 : ${widget.aquariumDTO.size?.split("/")[2] ?? "0"} cm"),
          Text(
            " 부피 : ${int.parse(widget.aquariumDTO.size?.split("/")[0] ?? "0") * int.parse(widget.aquariumDTO.size?.split("/")[1] ?? "0") * int.parse(widget.aquariumDTO.size?.split("/")[2] ?? "0") / 1000} 리터",
            style: const TextStyle(color: Colors.black),
          ),
          //
          if (onlyFishList.isNotEmpty)
            Container(margin: const EdgeInsets.only(top: 15), child: Text("물고기", style: TextStyle(fontSize: 17, color: Colors.grey[700]))),
          for (FishDTO fishDTO in onlyFishList) buildFishText(fishDTO),
          //
          if (onlyOtherList.isNotEmpty)
            Container(margin: const EdgeInsets.only(top: 15), child: Text("기타 생물", style: TextStyle(fontSize: 17, color: Colors.grey[700]))),
          for (FishDTO fishDTO in onlyOtherList) buildFishText(fishDTO),
          //
          if (onlyPlantList.isNotEmpty)
            Container(margin: const EdgeInsets.only(top: 15), child: Text("수초", style: TextStyle(fontSize: 17, color: Colors.grey[700]))),
          for (FishDTO fishDTO in onlyPlantList) buildFishText(fishDTO),
          //
          if (widget.aquariumDTO.equipmentDTOList.isNotEmpty)
            Container(margin: const EdgeInsets.only(top: 15), child: Text("장비", style: TextStyle(fontSize: 17, color: Colors.grey[700]))),
          for (EquipmentDTO equipmentDTO in widget.aquariumDTO.equipmentDTOList) Text(" - ${equipmentDTO.category} : ${equipmentDTO.name} "),
          //
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Row buildFishText(FishDTO fishDTO) {
    return Row(
      children: [
        Text(" - ${fishDTO.name} ", style: const TextStyle(fontSize: 15)),
        const SizedBox(width: 5),
        Text(
          "${fishDTO.quantity != null && fishDTO.quantity != 0 ? "x${fishDTO.quantity}, " : ""}",
          style: TextStyle(fontSize: 13, color: Colors.grey[700], fontFamily: "JamsilRegular"),
        ),
        Text(
          "${fishDTO.isMale == null ? "" : fishDTO.isMale! ? "수컷, " : "암컷, "}",
          style: TextStyle(fontSize: 13, color: Colors.grey[700], fontFamily: "JamsilRegular"),
        ),
        if (fishDTO.book != null)
          Text(
            "${fishDTO.book!.normalName}",
            style: TextStyle(fontSize: 13, color: Colors.grey[700], fontFamily: "JamsilRegular"),
          ),
      ],
    );
  }
}
