import 'package:fishfront/data/model/user.dart';
import 'package:intl/intl.dart';

class Aquarium {
  int id;
  User user;
  // List<Fish> fishList;
  // List<Schedule> scheduleList;
  // List<Board> boardList;
  String title;
  String intro;
  String photo;
  DateTime? createdAt;
  DateTime? updatedAt;

  Aquarium(this.id, this.user, this.title, this.intro, this.photo, this.createdAt, this.updatedAt);

  // 1. Dart 객체를 통신을 위한 Map 형태로 변환합니다.
  Map<String, dynamic> toJson() =>
      {"id": id, "user": user, "title": title, "intro": intro, "photo": photo, "createdAt": createdAt, "updatedAt": updatedAt};

  // 2. Map 형태로 받아서 Dart 객체로 변환합니다.
  // 이니셜라이저: 안쓰고 {} 안에 적으면 타이밍상 필드 초기화가 안됨
  // 이름이 있는 생성자
  Aquarium.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        user = User.fromJson(json["user"]),
        title = json["title"],
        intro = json["intro"],
        photo = json["photo"],
        createdAt = json["createdAt"] == null ? null : DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = json["updatedAt"] == null ? null : DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]);
}
