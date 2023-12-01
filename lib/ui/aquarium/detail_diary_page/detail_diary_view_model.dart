import 'dart:io';

import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/aquarium_request_dto.dart';
import 'package:fishfront/data/dto/diary_dto.dart';
import 'package:fishfront/data/dto/diary_request_dto.dart';
import 'package:fishfront/data/dto/equipment_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/data/repository/aquarium_repository.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class DetailDiaryModel {
  List<DiaryDTO> diaryDTOList;
  String newSearchTerm;
  TextEditingController title;
  TextEditingController text;
  File? imageFile;

  DetailDiaryModel.copy(DetailDiaryModel copyState)
      : diaryDTOList = copyState.diaryDTOList,
        newSearchTerm = copyState.newSearchTerm,
        title = copyState.title,
        text = copyState.text,
        imageFile = copyState.imageFile;

  DetailDiaryModel({
    required this.diaryDTOList,
    required this.newSearchTerm,
    required this.title,
    required this.text,
    required this.imageFile,
  });
}

class DetailDiaryViewModel extends StateNotifier<DetailDiaryModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  DetailDiaryViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("다이어리노티파이어인잇");

    ParamStore paramStore = ref.read(paramProvider);

    List<DiaryDTO> diaryDTOList = ref
        .read(mainProvider)!
        .aquariumDTOList //
        .firstWhere((element) => element.id == paramStore.aquariumDetailId)
        .diaryDTOList;

    TextEditingController title = new TextEditingController();
    TextEditingController text = new TextEditingController();

    state = await DetailDiaryModel(
      diaryDTOList: diaryDTOList,
      newSearchTerm: "",
      title: title,
      text: text,
      imageFile: null,
    );
  }

  Future<void> notifySearch(String newSearchTerm) async {
    print("notifySearch : ${newSearchTerm}");

    DetailDiaryModel copyState = state!;
    copyState.newSearchTerm = newSearchTerm;
    state = DetailDiaryModel.copy(copyState);
  }

  Future<void> notifyImageFile(File imageFile) async {
    print("notifyImageFile : ${imageFile}");

    DetailDiaryModel copyState = state!;
    copyState.imageFile = imageFile;
    state = DetailDiaryModel.copy(copyState);
  }

//
}

final detailDiaryProvider = StateNotifierProvider.autoDispose<DetailDiaryViewModel, DetailDiaryModel?>((ref) {
  // return new DetailOtherViewModel(ref, null)..notifyInit();
  return new DetailDiaryViewModel(ref, null);
});
