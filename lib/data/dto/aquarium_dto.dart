import 'package:fishfront/data/dto/equipment_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/model/user.dart';
import 'package:intl/intl.dart';

class AquariumDTO {
  int id;
  String title;
  String? intro;
  String? photo;
  bool? isFreshWater;
  String? size; // 길이/폭/높이
  DateTime createdAt;
  DateTime updatedAt;
  List<FishDTO> fishDTOList;
  List<ScheduleDTO> scheduleDTOList;
  List<EquipmentDTO> equipmentDTOList;

  AquariumDTO(this.id, this.title, this.intro, this.photo, this.isFreshWater, this.size, this.createdAt, this.updatedAt, this.fishDTOList,
      this.scheduleDTOList, this.equipmentDTOList);

  AquariumDTO.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        intro = json["intro"] ?? "",
        photo = json["photo"],
        isFreshWater = json["isFreshWater"],
        size = json["size"],
        createdAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]),
        fishDTOList = (json["fishDTOList"] as List).map((jsonFishDTO) => FishDTO.fromJson(jsonFishDTO)).toList(),
        scheduleDTOList = (json["scheduleDTOList"] as List).map((jsonScheduleDTO) => ScheduleDTO.fromJson(jsonScheduleDTO)).toList(),
        equipmentDTOList = (json["equipmentDTOList"] as List).map((jsonEquipmentDTO) => EquipmentDTO.fromJson(jsonEquipmentDTO)).toList();

  @override
  String toString() {
    return 'AquariumDTO{id: $id, title: $title, intro: $intro, photo: $photo, isFreshWater: $isFreshWater, size: $size, createdAt: $createdAt, updatedAt: $updatedAt, fishDTOList: $fishDTOList, scheduleDTOList: $scheduleDTOList, equipmentDTOList: $equipmentDTOList}';
  }
}
