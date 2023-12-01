import 'package:intl/intl.dart';

class DiaryDTO {
  int id;
  int aquariumId;
  String? title;
  String? text;
  String? photo;
  DateTime createdAt;
  DateTime? updatedAt;

  DiaryDTO(this.id, this.aquariumId, this.title, this.text, this.photo, this.createdAt, this.updatedAt);

  // 1. Dart 객체를 통신을 위한 Map 형태로 변환합니다.
  Map<String, dynamic> toJson() => {
        "id": id,
        "aquariumId": aquariumId,
        "title": title,
        "text": text,
        "photo": photo,
        "createdAt": createdAt.toString(),
        "updatedAt": updatedAt.toString(),
      };

  // 2. Map 형태로 받아서 Dart 객체로 변환합니다.
  // 이니셜라이저: 안쓰고 {} 안에 적으면 타이밍상 필드 초기화가 안됨
  // 이름이 있는 생성자
  DiaryDTO.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        aquariumId = json["aquariumId"],
        title = json["title"],
        text = json["text"],
        photo = json["photo"],
        createdAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = json["updatedAt"] == null ? null : DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]);

  @override
  String toString() {
    return 'DiaryDTO{id: $id, aquariumId: $aquariumId, title: $title, text: $text, photo: $photo, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
