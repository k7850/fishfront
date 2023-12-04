import 'package:intl/intl.dart';

class BoardMainDTO {
  int id;
  int userId;
  String username;
  String title;
  String? video;
  List<String> photoList;
  DateTime? createdAt;
  DateTime? updatedAt;
  int viewCount;
  int commentCount;
  bool isView;
  bool? isAquarium;

  BoardMainDTO(
    this.id,
    this.userId,
    this.username,
    this.title,
    this.video,
    this.createdAt,
    this.updatedAt,
    this.photoList,
    this.viewCount,
    this.commentCount,
    this.isView,
    this.isAquarium,
  );

  BoardMainDTO.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userId = json["userId"],
        username = json["username"],
        title = json["title"],
        video = json["video"],
        createdAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]),
        photoList = (json["photoList"] as List).map((photo) => photo.toString()).toList(),
        viewCount = json["viewCount"],
        commentCount = json["commentCount"],
        isAquarium = json["isAquarium"],
        isView = json["isView"];

  @override
  String toString() {
    return 'BoardMainDTO{id: $id, userId: $userId, username: $username, title: $title, video: $video, photoList: $photoList, createdAt: $createdAt, updatedAt: $updatedAt, viewCount: $viewCount, commentCount: $commentCount, isView: $isView, isAquarium: $isAquarium}';
  }
}
