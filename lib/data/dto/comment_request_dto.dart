import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/equipment_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:intl/intl.dart';

class CommentRequestDTO {
  String text;

  CommentRequestDTO({required this.text});

  Map<String, dynamic> toJson() => {
        "text": text,
      };

  @override
  String toString() {
    return 'CommentRequestDTO{text: $text}';
  }
}
