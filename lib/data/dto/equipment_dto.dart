import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/model/user.dart';
import 'package:intl/intl.dart';

class EquipmentDTO {
  int id;
  int aquariumId;
  String category;
  String name;
  DateTime? createdAt;
  DateTime? updatedAt;

  EquipmentDTO.copy(EquipmentDTO CopyEquipmentDTO)
      : id = CopyEquipmentDTO.id,
        aquariumId = CopyEquipmentDTO.aquariumId,
        category = CopyEquipmentDTO.category,
        name = CopyEquipmentDTO.name,
        createdAt = CopyEquipmentDTO.createdAt,
        updatedAt = CopyEquipmentDTO.updatedAt;

  EquipmentDTO(this.id, this.aquariumId, this.category, this.name, this.createdAt, this.updatedAt);

  // 1. Dart 객체를 통신을 위한 Map 형태로 변환합니다.
  Map<String, dynamic> toJson() => {
        "id": id,
        "aquariumId": aquariumId,
        "category": category,
        "name": name,
        // "createdAt": createdAt.toString(),
        // "updatedAt": updatedAt.toString(),
      };

  // 2. Map 형태로 받아서 Dart 객체로 변환합니다.
  // 이니셜라이저: 안쓰고 {} 안에 적으면 타이밍상 필드 초기화가 안됨
  // 이름이 있는 생성자
  EquipmentDTO.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        aquariumId = json["aquariumId"],
        category = json["category"],
        name = json["name"],
        createdAt = json["createdAt"] == null ? null : DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = json["updatedAt"] == null ? null : DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]);

  @override
  String toString() {
    return 'EquipmentDTO{id: $id, aquariumId: $aquariumId, category: $category, name: $name, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
