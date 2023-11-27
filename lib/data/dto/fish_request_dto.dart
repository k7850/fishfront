import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:intl/intl.dart';

class FishRequestDTO {
  String fishClassEnum;
  String? name;
  String? text;
  int? quantity;
  bool? isMale;
  String? photo;
  String? price;

  FishRequestDTO(this.fishClassEnum, this.name, this.text, this.quantity, this.isMale, this.photo, this.price);

  Map<String, dynamic> toJson() => {
        "fishClassEnum": fishClassEnum,
        "name": name,
        "text": text,
        "quantity": quantity,
        "isMale": isMale,
        "photo": photo,
        "price": price,
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
        price = fishDTO.price;

  @override
  String toString() {
    return 'FishRequestDTO{fishClassEnum: $fishClassEnum, name: $name, text: $text, quantity: $quantity, isMale: $isMale, photo: $photo, price: $price}';
  }
}
