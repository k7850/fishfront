import 'package:fishfront/data/model/aquarium.dart';
import 'package:fishfront/data/model/user.dart';
import 'package:intl/intl.dart';

class Board {
  int id;
  User user;
  Aquarium aquarium;
  // List<boardPhoto> boardPhotoList;
  String title;
  String text;
  String video;
  DateTime? createdAt;
  DateTime? updatedAt;

  Board(this.id, this.user, this.aquarium, this.title, this.text, this.video, this.createdAt, this.updatedAt);

  // 1. Dart 객체를 통신을 위한 Map 형태로 변환합니다.
  Map<String, dynamic> toJson() =>
      {"id": id, "user": user, "aquarium": aquarium, "title": title, "text": text, "video": video, "createdAt": createdAt, "updatedAt": updatedAt};

  // 2. Map 형태로 받아서 Dart 객체로 변환합니다.
  // 이니셜라이저: 안쓰고 {} 안에 적으면 타이밍상 필드 초기화가 안됨
  // 이름이 있는 생성자
  Board.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        user = User.fromJson(json["user"]),
        aquarium = Aquarium.fromJson(json["aquarium"]),
        title = json["title"],
        text = json["text"],
        video = json["video"],
        createdAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]);
}
