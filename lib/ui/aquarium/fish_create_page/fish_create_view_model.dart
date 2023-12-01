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

class FishCreateModel {
  // FishDTO fishDTO;
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

  FishCreateModel.copy(FishCreateModel copyState)
      // : fishDTO = copyState.fishDTO,
      : aquariumDTO = copyState.aquariumDTO,
        name = copyState.name,
        text = copyState.text,
        price = copyState.price,
        fishClassEnum = copyState.fishClassEnum,
        quantity = copyState.quantity,
        isMale = copyState.isMale,
        photo = copyState.photo,
        book = copyState.book,
        imageFile = copyState.imageFile;

  FishCreateModel({
    // required this.fishDTO,
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

class FishCreateViewModel extends StateNotifier<FishCreateModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  FishCreateViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("피시업데이트노티파이어인잇");
    ParamStore paramStore = ref.read(paramProvider);

    AquariumDTO aquariumDTO = ref
        .read(mainProvider)!
        .aquariumDTOList //
        .firstWhere((element) => element.id == paramStore.aquariumDetailId);

    TextEditingController name = TextEditingController();
    TextEditingController text = TextEditingController();
    TextEditingController price = TextEditingController();

    state = await FishCreateModel(
      // fishDTO: fishDTO,
      aquariumDTO: aquariumDTO,
      name: name,
      text: text,
      price: price,
      fishClassEnum: FishClassEnum.FISH,
      quantity: 0,
      isMale: null,
      photo: null,
      book: null,
      imageFile: null,
    );
  }

  Future<void> notifyImageFile(File imageFile) async {
    print("notifyImageFile : ${imageFile}");

    FishCreateModel copyState = state!;
    copyState.imageFile = imageFile;
    state = FishCreateModel.copy(copyState);
  }

  Future<void> notifyName(String str) async {
    print("notifyName : ${str}");

    FishCreateModel copyState = state!;
    copyState.name.text = str;
    state = FishCreateModel.copy(copyState);
  }

  Future<void> notifyText(String str) async {
    print("notifyText : ${str}");

    FishCreateModel copyState = state!;
    copyState.text.text = str;
    state = FishCreateModel.copy(copyState);
  }

  Future<void> notifyPrice(String str) async {
    print("notifyPrice : ${str}");

    FishCreateModel copyState = state!;
    copyState.price.text = str;
    state = FishCreateModel.copy(copyState);
  }

  Future<void> notifyAquariumDTO(AquariumDTO aquariumDTO) async {
    print("notifyAquariumDTO : ${aquariumDTO}");

    FishCreateModel copyState = state!;
    copyState.aquariumDTO = aquariumDTO;
    state = FishCreateModel.copy(copyState);
  }

  Future<void> notifyFishClassEnum(FishClassEnum fishClassEnum) async {
    print("notifyFishClassEnum : ${fishClassEnum}");

    FishCreateModel copyState = state!;
    copyState.fishClassEnum = fishClassEnum;
    state = FishCreateModel.copy(copyState);
  }

  Future<void> notifyQuantity(int quantity) async {
    print("notifyQuantity : ${quantity}");

    FishCreateModel copyState = state!;
    copyState.quantity = quantity;
    state = FishCreateModel.copy(copyState);
  }

  Future<void> notifyIsMale(bool? isMale) async {
    print("notifyIsMale : ${isMale}");

    FishCreateModel copyState = state!;
    copyState.isMale = isMale;
    state = FishCreateModel.copy(copyState);
  }

  Future<void> notifyBook(Book? book) async {
    print("notifyBook : ${book}");

    FishCreateModel copyState = state!;
    copyState.book = book;
    state = FishCreateModel.copy(copyState);
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

final fishCreateProvider = StateNotifierProvider.autoDispose<FishCreateViewModel, FishCreateModel?>((ref) {
  // return new FishUpdateViewModel(ref, null)..notifyInit();
  return new FishCreateViewModel(ref, null);
});
