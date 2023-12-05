import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/equipment_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:intl/intl.dart';

class BoardRequestDTO {
  String title;
  String? text;
  int aquariumId;
  int fishId;
  // String? video;
  // List<String> photoList;

  BoardRequestDTO({required this.title, this.text, this.aquariumId = -1, this.fishId = -1});

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "aquariumId": aquariumId,
        "fishId": fishId,
      };

  @override
  String toString() {
    return 'BoardRequestDTO{title: $title, text: $text, aquariumId: $aquariumId, fishId: $fishId}';
  }
}
