import 'package:intl/intl.dart';

class CommentDTO {
  final int id;
  final int boardId;
  final int userId;
  final String username;
  final String text;
  bool? isDelete;
  DateTime? createdAt;
  DateTime? updatedAt;
  int likeCommentCount;
  int dislikeCommentCount;
  bool isMyLike;
  bool isMyDislike;

  CommentDTO(this.id, this.boardId, this.userId, this.username, this.text, this.isDelete, this.createdAt, this.updatedAt, this.likeCommentCount,
      this.dislikeCommentCount, this.isMyLike, this.isMyDislike);

  // Map 형태로 받아서 Dart 객체로 변환합니다.
  CommentDTO.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        boardId = json["boardId"],
        userId = json["userId"],
        username = json["username"],
        text = json["text"],
        isDelete = json["isDelete"],
        createdAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]),
        likeCommentCount = json["likeCommentCount"],
        dislikeCommentCount = json["dislikeCommentCount"],
        isMyLike = json["isMyLike"],
        isMyDislike = json["isMyDislike"];

  @override
  String toString() {
    return 'CommentDTO{id: $id, boardId: $boardId, userId: $userId, username: $username, text: $text, isDelete: $isDelete, createdAt: $createdAt, updatedAt: $updatedAt, likeCommentCount: $likeCommentCount, dislikeCommentCount: $dislikeCommentCount, isMyLike: $isMyLike, isMyDislike: $isMyDislike}';
  }
}
