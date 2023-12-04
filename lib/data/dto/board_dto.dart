import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/comment_dto.dart';
import 'package:fishfront/data/dto/emoticon_count.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/model/aquarium.dart';
import 'package:fishfront/data/model/user.dart';
import 'package:intl/intl.dart';

class BoardDTO {
  int id;
  int userId;
  String username;
  String title;
  String? text;
  String? video;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String> photoList;
  AquariumDTO? aquariumDTO;
  FishDTO? fishDTO;
  int viewCount;
  List<CommentDTO> commentDTOList;
  EmoticonCount emoticonCount;

  BoardDTO(
    this.id,
    this.userId,
    this.username,
    this.title,
    this.text,
    this.video,
    this.createdAt,
    this.updatedAt,
    this.photoList,
    this.aquariumDTO,
    this.fishDTO,
    this.viewCount,
    this.commentDTOList,
    this.emoticonCount,
  );

  BoardDTO.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userId = json["userId"],
        username = json["username"],
        title = json["title"],
        text = json["text"],
        video = json["video"],
        createdAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]),
        photoList = (json["photoList"] as List).map((photo) => photo.toString()).toList(),
        aquariumDTO = json["aquariumDTO"] == null ? null : AquariumDTO.fromJson(json["aquariumDTO"]),
        fishDTO = json["fishDTO"] == null ? null : FishDTO.fromJson(json["fishDTO"]),
        viewCount = json["viewCount"],
        commentDTOList = (json["commentDTOList"] as List).map((comment) => CommentDTO.fromJson(comment)).toList(),
        emoticonCount = EmoticonCount.fromJson(json["emoticonCount"]);

  @override
  String toString() {
    return 'BoardDTO{id: $id, userId: $userId, username: $username, title: $title, text: $text, video: $video, createdAt: $createdAt, updatedAt: $updatedAt, photoList: $photoList, aquariumDTO: $aquariumDTO, fishDTO: $fishDTO, commentDTOList: $commentDTOList}';
  }
}
