import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:intl/intl.dart';

class DiaryRequestDTO {
  String? title;
  String? text;
  String? base64Image;

  DiaryRequestDTO({this.title, this.text, this.base64Image});

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "base64Image": base64Image,
      };

  @override
  String toString() {
    return 'DiaryRequestDTO{title: $title, text: $text, base64Image: $base64Image}';
  }
}
