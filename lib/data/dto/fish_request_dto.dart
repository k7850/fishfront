import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:intl/intl.dart';

class FishRequestDTO {
  FishClassEnum fishClassEnum;
  String? name;
  String? text;
  int? quantity;
  bool? isMale;
  String? photo;
  String? price;
  int? bookId;

  FishRequestDTO(this.fishClassEnum, this.name, this.text, this.quantity, this.isMale, this.photo, this.price, this.bookId);

  Map<String, dynamic> toJson() => {
        "fishClassEnum": fishClassEnum.toString().split(".")[1],
        "name": name,
        "text": text,
        "quantity": quantity,
        "isMale": isMale,
        "photo": photo,
        "price": price,
        "bookId": bookId,
      };

  FishRequestDTO.fromFishDTO(FishDTO fishDTO)
      : fishClassEnum = fishDTO.fishClassEnum,
        name = fishDTO.name != null
            ? fishDTO.name
            : fishDTO.book?.normalName == null
                ? "이름 없음"
                : fishDTO.book?.normalName,
        text = fishDTO.text,
        quantity = fishDTO.quantity,
        isMale = fishDTO.isMale,
        photo = fishDTO.photo,
        price = fishDTO.price,
        bookId = fishDTO.book?.id;

  @override
  String toString() {
    return 'FishRequestDTO{fishClassEnum: $fishClassEnum, name: $name, text: $text, quantity: $quantity, isMale: $isMale, photo: $photo, price: $price, bookId: $bookId}';
  }
}
