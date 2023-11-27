import 'package:fishfront/data/model/book.dart';
import 'package:intl/intl.dart';

class FishDTO {
  int id;
  int aquariumId;
  Book? book;
  String fishClassEnum;
  String? name;
  String? text;
  int? quantity;
  bool? isMale;
  String? photo;
  String? price;
  DateTime createdAt;
  DateTime updatedAt;

  FishDTO(this.id, this.aquariumId, this.book, this.fishClassEnum, this.name, this.text, this.quantity, this.isMale, this.photo, this.price,
      this.createdAt, this.updatedAt);

  FishDTO.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        aquariumId = json["aquariumId"],
        book = json["book"] == null ? null : Book.fromJson(json["book"]),
        fishClassEnum = json["fishClassEnum"],
        name = json["name"],
        text = json["text"],
        quantity = json["quantity"],
        isMale = json["isMale"],
        photo = json["photo"],
        price = json["price"],
        createdAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]);

  @override
  String toString() {
    return 'FishDTO{id: $id, aquariumId: $aquariumId, book: $book, fishClassEnum: $fishClassEnum, name: $name, text: $text, quantity: $quantity, isMale: $isMale, photo: $photo, price: $price, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
