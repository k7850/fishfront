// import 'package:fishfront/data/model/aquarium.dart';
// import 'package:fishfront/data/model/user.dart';
// import 'package:intl/intl.dart';
//
// class MainBoardDTO {
//   int id;
//   int userId;
//   String username;
//   String title;
//   String text;
//   List<String>? photoList;
//   String? video;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   MainBoardDTO(this.id, this.userId, this.username, this.title, this.text, this.photoList, this.video, this.createdAt, this.updatedAt);
//
//   MainBoardDTO.fromJson(Map<String, dynamic> json)
//       : id = json["id"],
//         userId = json["userId"],
//         username = json["username"],
//         title = json["title"],
//         text = json["text"],
//         photoList = (json["photoList"] as List).map((e) => e.toString()).toList(),
//         video = json["video"],
//         createdAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
//         updatedAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]);
// }
