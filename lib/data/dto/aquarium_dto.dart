import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/model/user.dart';
import 'package:intl/intl.dart';

class AquariumDTO {
  int id;
  String title;
  String intro;
  String? photo;
  bool? isFreshWater;
  String? size; // 길이/폭/높이
  String? s1;
  String? s2;
  String? s3;
  String? s4;
  String? s5;
  DateTime createdAt;
  DateTime updatedAt;
  List<FishDTO> fishDTOList;
  List<ScheduleDTO> scheduleDTOList;

  AquariumDTO(this.id, this.title, this.intro, this.photo, this.isFreshWater, this.size, this.s1, this.s2, this.s3, this.s4, this.s5, this.createdAt,
      this.updatedAt, this.fishDTOList, this.scheduleDTOList);

  AquariumDTO.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        intro = json["intro"],
        photo = json["photo"],
        isFreshWater = json["isFreshWater"],
        size = json["size"],
        s1 = json["s1"],
        s2 = json["s2"],
        s3 = json["s3"],
        s4 = json["s4"],
        s5 = json["s5"],
        createdAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]),
        fishDTOList = (json["fishDTOList"] as List).map((jsonFishDTO) => FishDTO.fromJson(jsonFishDTO)).toList(),
        scheduleDTOList = (json["scheduleDTOList"] as List).map((jsonScheduleDTO) => ScheduleDTO.fromJson(jsonScheduleDTO)).toList();

  @override
  String toString() {
    return 'AquariumDTO{id: $id, title: $title, intro: $intro, photo: $photo, isFreshWater: $isFreshWater, size: $size, s1: $s1, s2: $s2, s3: $s3, s4: $s4, s5: $s5, createdAt: $createdAt, updatedAt: $updatedAt, fishDTOList: $fishDTOList, scheduleDTOList: $scheduleDTOList}';
  }
}
