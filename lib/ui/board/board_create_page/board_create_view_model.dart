import 'dart:io';

import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/diary_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardCreateModel {
  TextEditingController title;
  TextEditingController text;
  File? videoFile;
  List<File>? imageFileList;

  AquariumDTO? aquariumDTO;
  FishDTO? fishDTO;

  BoardCreateModel.copy(BoardCreateModel copyState)
      : title = copyState.title,
        text = copyState.text,
        videoFile = copyState.videoFile,
        imageFileList = copyState.imageFileList,
        aquariumDTO = copyState.aquariumDTO,
        fishDTO = copyState.fishDTO;

  BoardCreateModel({
    required this.title,
    required this.text,
    this.videoFile,
    this.imageFileList,
    this.aquariumDTO,
    this.fishDTO,
  });
}

class BoardCreateViewModel extends StateNotifier<BoardCreateModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  BoardCreateViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("다이어리노티파이어인잇");

    // ParamStore paramStore = ref.read(paramProvider);
    //
    // List<DiaryDTO> diaryDTOList = ref
    //     .read(mainProvider)!
    //     .aquariumDTOList //
    //     .firstWhere((element) => element.id == paramStore.aquariumDetailId)
    //     .diaryDTOList;

    TextEditingController title = new TextEditingController();
    TextEditingController text = new TextEditingController();

    state = await BoardCreateModel(
      title: title,
      text: text,
    );
  }

  Future<void> notifyImageFileList(List<File>? imageFileList) async {
    print("notifyImageFileList : ${imageFileList}");

    BoardCreateModel copyState = state!;
    copyState.imageFileList = imageFileList;
    state = BoardCreateModel.copy(copyState);
  }

  Future<void> notifyVideoFile(File? videoFile) async {
    print("notifyVideoFile : ${videoFile}");

    BoardCreateModel copyState = state!;
    copyState.videoFile = videoFile;
    state = BoardCreateModel.copy(copyState);
  }

  Future<void> notifySelectAquariumDTO(AquariumDTO? aquariumDTO) async {
    print("notifySelectAquariumDTO : ${aquariumDTO}");

    BoardCreateModel copyState = state!;
    copyState.aquariumDTO = aquariumDTO;
    state = BoardCreateModel.copy(copyState);
  }

  Future<void> notifySelectFishDTO(FishDTO? fishDTO) async {
    print("notifySelectFishDTO : ${fishDTO}");

    BoardCreateModel copyState = state!;
    copyState.fishDTO = fishDTO;
    state = BoardCreateModel.copy(copyState);
  }

  @override
  void dispose() {
    print("보드생성 디스포즈됨");
    state!.text.dispose();
    state!.title.dispose();
    super.dispose();
  }

//
}

final boardCreateProvider = StateNotifierProvider.autoDispose<BoardCreateViewModel, BoardCreateModel?>((ref) {
  // return new DetailOtherViewModel(ref, null)..notifyInit();
  return new BoardCreateViewModel(ref, null);
});
