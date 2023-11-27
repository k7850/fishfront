import 'package:fishfront/data/model/user.dart';
import 'package:intl/intl.dart';

class Book {
  int id;
  String normalName;
  String? biologyName;
  int? difficulty;
  String? photo;
  String? text;
  String? fishClassEnum;
  DateTime? createdAt;
  DateTime? updatedAt;

  Book(this.id, this.normalName, this.biologyName, this.difficulty, this.photo, this.text, this.fishClassEnum, this.createdAt, this.updatedAt);

  // 1. Dart 객체를 통신을 위한 Map 형태로 변환합니다.
  Map<String, dynamic> toJson() => {
        "id": id,
        "normalName": normalName,
        "biologyName": biologyName,
        "difficulty": difficulty,
        "photo": photo,
        "text": text,
        "fishClassEnum": fishClassEnum,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };

  // 2. Map 형태로 받아서 Dart 객체로 변환합니다.
  // 이니셜라이저: 안쓰고 {} 안에 적으면 타이밍상 필드 초기화가 안됨
  // 이름이 있는 생성자
  Book.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        normalName = json["normalName"],
        biologyName = json["biologyName"],
        difficulty = json["difficulty"],
        photo = json["photo"],
        text = json["text"],
        fishClassEnum = json["fishClassEnum"],
        createdAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]);

  @override
  String toString() {
    return 'Book{id: $id, normalName: $normalName, biologyName: $biologyName, difficulty: $difficulty, photo: $photo, text: $text, fishClassEnum: $fishClassEnum, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
