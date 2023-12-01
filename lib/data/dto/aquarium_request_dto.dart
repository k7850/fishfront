import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/equipment_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:intl/intl.dart';

class AquariumRequestDTO {
  String title;
  String? intro;
  String? photo;
  bool? isFreshWater;
  String? size;
  List<EquipmentDTO> equipmentDTOList;

  String? base64Image;

  AquariumRequestDTO({required this.title, this.intro, this.photo, this.isFreshWater, this.size, required this.equipmentDTOList});

  Map<String, dynamic> toJson() => {
        "title": title,
        "intro": intro,
        "photo": photo,
        "isFreshWater": isFreshWater,
        "size": size,
        "equipmentDTOList": equipmentDTOList.map((equipment) => equipment.toJson()).toList(),
        // "equipmentDTOList": List<dynamic>.from(equipmentDTOList.map((equipment) => equipment.toJson())),
        "base64Image": base64Image,
      };

// AquariumRequestDTO.fromAquariumDTO(AquariumDTO aquariumDTO)
  //     : title = aquariumDTO.title,
  //       intro = aquariumDTO.intro,
  //       isFreshWater = aquariumDTO.isFreshWater,
  //       size = aquariumDTO.size,
  //       equipmentDTOList = aquariumDTO.equipmentDTOList;

  @override
  String toString() {
    return 'AquariumRequestDTO{title: $title, intro: $intro, photo: $photo, isFreshWater: $isFreshWater, size: $size, equipmentDTOList: $equipmentDTOList, base64Image: $base64Image}';
  }
}
