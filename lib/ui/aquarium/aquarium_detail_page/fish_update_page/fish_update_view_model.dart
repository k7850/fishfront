import 'dart:io';

import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/data/repository/aquarium_repository.dart';
import 'package:fishfront/data/repository/book_repository.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishUpdateModel {
  FishDTO fishDTO;
  AquariumDTO aquariumDTO;

  TextEditingController name;
  TextEditingController text;
  TextEditingController price;

  FishClassEnum fishClassEnum;
  int quantity;

  bool? isMale;
  String? photo;
  Book? book;

  File? imageFile;

  FishUpdateModel({
    required this.fishDTO,
    required this.aquariumDTO,
    required this.name,
    required this.text,
    required this.price,
    required this.fishClassEnum,
    required this.quantity,
    this.isMale,
    this.photo,
    this.book,
    this.imageFile,
  });
}

class FishUpdateViewModel extends StateNotifier<FishUpdateModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  FishUpdateViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("피시업데이트노티파이어인잇");
    ParamStore paramStore = ref.read(paramProvider);

    FishDTO fishDTO = ref
        .read(mainProvider)!
        .aquariumDTOList
        .expand((element) => element.fishDTOList)
        .firstWhere((element) => element.id == paramStore.fishDetailId);

    AquariumDTO aquariumDTO = ref
        .read(mainProvider)!
        .aquariumDTOList //
        .firstWhere((element) => element.id == fishDTO.aquariumId);

    TextEditingController name = TextEditingController(text: "${fishDTO.name ?? ""}");
    TextEditingController text = TextEditingController(text: "${fishDTO.text ?? ""}");
    TextEditingController price = TextEditingController(text: "${fishDTO.price ?? ""}");

    FishClassEnum fishClassEnum = fishDTO.fishClassEnum;
    int quantity = fishDTO.quantity ?? 0;
    bool? isMale = fishDTO.isMale;
    String? photo = fishDTO.photo;
    Book? book = fishDTO.book;

    state = await FishUpdateModel(
      fishDTO: fishDTO,
      aquariumDTO: aquariumDTO,
      name: name,
      text: text,
      price: price,
      fishClassEnum: fishClassEnum,
      quantity: quantity,
      isMale: isMale,
      photo: photo,
      book: book,
      imageFile: null,
    );
  }

  Future<void> notifyImageFile(File imageFile) async {
    print("notifyImageFile : ${imageFile}");

    state = FishUpdateModel(
      fishDTO: state!.fishDTO,
      aquariumDTO: state!.aquariumDTO,
      name: state!.name,
      text: state!.text,
      price: state!.price,
      fishClassEnum: state!.fishClassEnum,
      quantity: state!.quantity,
      isMale: state!.isMale,
      photo: state!.photo,
      book: state!.book,
      imageFile: imageFile,
    );
  }

  Future<void> notifyName(String str) async {
    print("notifyName : ${str}");

    var controller = state!.name;
    controller.text = str;

    state = FishUpdateModel(
      fishDTO: state!.fishDTO,
      aquariumDTO: state!.aquariumDTO,
      name: controller,
      text: state!.text,
      price: state!.price,
      fishClassEnum: state!.fishClassEnum,
      quantity: state!.quantity,
      isMale: state!.isMale,
      photo: state!.photo,
      book: state!.book,
      imageFile: state!.imageFile,
    );
  }

  Future<void> notifyText(String str) async {
    print("notifyText : ${str}");

    var controller = state!.text;
    controller.text = str;

    state = FishUpdateModel(
      fishDTO: state!.fishDTO,
      aquariumDTO: state!.aquariumDTO,
      name: state!.name,
      text: controller,
      price: state!.price,
      fishClassEnum: state!.fishClassEnum,
      quantity: state!.quantity,
      isMale: state!.isMale,
      photo: state!.photo,
      book: state!.book,
      imageFile: state!.imageFile,
    );
  }

  Future<void> notifyPrice(String str) async {
    print("notifyPrice : ${str}");

    var controller = state!.price;
    controller.text = str;

    state = FishUpdateModel(
      fishDTO: state!.fishDTO,
      aquariumDTO: state!.aquariumDTO,
      name: state!.name,
      text: state!.text,
      price: controller,
      fishClassEnum: state!.fishClassEnum,
      quantity: state!.quantity,
      isMale: state!.isMale,
      photo: state!.photo,
      book: state!.book,
      imageFile: state!.imageFile,
    );
  }

  Future<void> notifyAquariumDTO(AquariumDTO aquariumDTO) async {
    print("notifyAquariumDTO : ${aquariumDTO}");

    state = FishUpdateModel(
      fishDTO: state!.fishDTO,
      aquariumDTO: aquariumDTO,
      name: state!.name,
      text: state!.text,
      price: state!.price,
      fishClassEnum: state!.fishClassEnum,
      quantity: state!.quantity,
      isMale: state!.isMale,
      photo: state!.photo,
      book: state!.book,
      imageFile: state!.imageFile,
    );
  }

  Future<void> notifyFishClassEnum(FishClassEnum fishClassEnum) async {
    print("notifyFishClassEnum : ${fishClassEnum}");

    state = FishUpdateModel(
      fishDTO: state!.fishDTO,
      aquariumDTO: state!.aquariumDTO,
      name: state!.name,
      text: state!.text,
      price: state!.price,
      fishClassEnum: fishClassEnum,
      quantity: state!.quantity,
      isMale: state!.isMale,
      photo: state!.photo,
      book: state!.book,
      imageFile: state!.imageFile,
    );
  }

  Future<void> notifyQuantity(int quantity) async {
    print("notifyQuantity : ${quantity}");

    state = FishUpdateModel(
      fishDTO: state!.fishDTO,
      aquariumDTO: state!.aquariumDTO,
      name: state!.name,
      text: state!.text,
      price: state!.price,
      fishClassEnum: state!.fishClassEnum,
      quantity: quantity,
      isMale: state!.isMale,
      photo: state!.photo,
      book: state!.book,
      imageFile: state!.imageFile,
    );
  }

  Future<void> notifyIsMale(bool? isMale) async {
    print("notifyIsMale : ${isMale}");

    state = FishUpdateModel(
      fishDTO: state!.fishDTO,
      aquariumDTO: state!.aquariumDTO,
      name: state!.name,
      text: state!.text,
      price: state!.price,
      fishClassEnum: state!.fishClassEnum,
      quantity: state!.quantity,
      isMale: isMale,
      photo: state!.photo,
      book: state!.book,
      imageFile: state!.imageFile,
    );
  }

  Future<void> notifyBook(Book? book) async {
    print("notifyBook : ${book}");

    state = FishUpdateModel(
      fishDTO: state!.fishDTO,
      aquariumDTO: state!.aquariumDTO,
      name: state!.name,
      text: state!.text,
      price: state!.price,
      fishClassEnum: state!.fishClassEnum,
      quantity: state!.quantity,
      isMale: state!.isMale,
      photo: state!.photo,
      book: book,
      imageFile: state!.imageFile,
    );
  }

  @override
  void dispose() {
    print("피시업데이트 디스포즈됨");

    state!.name.dispose();
    state!.text.dispose();
    state!.price.dispose();

    super.dispose();
  }

//
}

final fishUpdateProvider = StateNotifierProvider.autoDispose<FishUpdateViewModel, FishUpdateModel?>((ref) {
  // return new FishUpdateViewModel(ref, null)..notifyInit();
  return new FishUpdateViewModel(ref, null);
});
