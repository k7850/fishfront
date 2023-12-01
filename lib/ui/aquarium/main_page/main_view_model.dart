import 'dart:io';

import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/aquarium_request_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/fish_request_dto.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/dto/schedule_request_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/data/repository/aquarium_repository.dart';
import 'package:fishfront/data/repository/board_repository.dart';
import 'package:fishfront/data/repository/book_repository.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/detail_other_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class MainModel {
  List<AquariumDTO> aquariumDTOList;

  MainModel({required this.aquariumDTOList});
}

class MainViewModel extends StateNotifier<MainModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  MainViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("메인아쿠아리움노티파이어인잇");
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchAquarium(sessionUser.jwt!);

    if (responseDTO.success == false) {
      print("notifyInit실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      notifyInit();
      return;
    }

    state = MainModel(aquariumDTOList: responseDTO.data);
  }

  Future<void> notifyScheduleCheck(int scheduleId, bool scheduleIsCompleted) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchScheduleCheck(sessionUser.jwt!, scheduleId, scheduleIsCompleted);

    if (responseDTO.success == false) {
      print("스케줄체크실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      notifyInit();
      return;
    }

    ScheduleDTO scheduleDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    aquariumDTOList
        .firstWhere((e) => e.id == scheduleDTO.aquariumId) //
        .scheduleDTOList //
        .firstWhere((e) => e.id == scheduleDTO.id) //
        .isCompleted = scheduleDTO.isCompleted;

    state = MainModel(aquariumDTOList: aquariumDTOList);
  }

  Future<void> notifyScheduleDelete(int scheduleId) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchScheduleDelete(sessionUser.jwt!, scheduleId);

    if (responseDTO.success == false) {
      print("삭제실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      notifyInit();
      return;
    }

    ScheduleDTO scheduleDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    aquariumDTOList
        .firstWhere((e) => e.id == scheduleDTO.aquariumId) //
        .scheduleDTOList //
        .removeWhere((e) => e.id == scheduleDTO.id);

    state = MainModel(aquariumDTOList: aquariumDTOList);
  }

  Future<void> notifyScheduleCreate(int aquariumId, ScheduleRequestDTO scheduleRequestDTO) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchScheduleCreate(sessionUser.jwt!, aquariumId, scheduleRequestDTO);

    if (responseDTO.success == false) {
      print("생성실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      notifyInit();
      return;
    }

    ScheduleDTO scheduleDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    aquariumDTOList
        .firstWhere((e) => e.id == scheduleDTO.aquariumId) //
        .scheduleDTOList //
        .add(scheduleDTO);

    state = MainModel(aquariumDTOList: aquariumDTOList);
  }

  Future<void> notifyFishDelete(int fishId) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchFishDelete(sessionUser.jwt!, fishId);

    if (responseDTO.success == false) {
      print("삭제실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      notifyInit();
      return;
    }

    FishDTO fishDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    aquariumDTOList
        .firstWhere((e) => e.id == fishDTO.aquariumId) //
        .fishDTOList //
        .removeWhere((e) => e.id == fishDTO.id);

    state = MainModel(aquariumDTOList: aquariumDTOList);
    mySnackbar(2000, mySnackbarRow1("${fishDTO.name}", " 삭제 성공", "", ""));
  }

  Future<void> notifyFishCreate(int aquariumId, FishRequestDTO fishRequestDTO, File? imageFile) async {
    print("${fishRequestDTO}");
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchFishCreate(sessionUser.jwt!, aquariumId, fishRequestDTO, imageFile);

    if (responseDTO.success == false) {
      print("생성실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      notifyInit();
      return;
    }

    FishDTO fishDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    aquariumDTOList
        .firstWhere((e) => e.id == fishDTO.aquariumId) //
        .fishDTOList //
        .add(fishDTO);

    state = MainModel(aquariumDTOList: aquariumDTOList);
    mySnackbar(2000, mySnackbarRow1("${fishDTO.name}", " 추가 성공", "", ""));
  }

  Future<void> notifyFishMove(FishDTO oldFishDTO, int aquariumId) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchFishMove(sessionUser.jwt!, oldFishDTO.id, aquariumId);

    if (responseDTO.success == false) {
      print("이동실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      notifyInit();
      return;
    }

    FishDTO newFishDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    aquariumDTOList
        .firstWhere((e) => e.id == oldFishDTO.aquariumId) //
        .fishDTOList //
        .removeWhere((e) => e.id == oldFishDTO.id);

    AquariumDTO aquariumDTO = aquariumDTOList.firstWhere((e) => e.id == newFishDTO.aquariumId);
    aquariumDTO.fishDTOList.add(newFishDTO);

    state = MainModel(aquariumDTOList: aquariumDTOList);

    mySnackbar(3000, mySnackbarRow1("${newFishDTO.name}", "가 ", "${aquariumDTO.title}", "으로 이동하였습니다."));
  }

  Future<void> notifyFishUpdate(int aquariumId, int fishId, FishRequestDTO fishRequestDTO, File? imageFile) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchFishUpdate(sessionUser.jwt!, aquariumId, fishId, fishRequestDTO, imageFile);

    if (responseDTO.success == false) {
      print("업데이트실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      notifyInit();
      return;
    }

    FishDTO fishDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    aquariumDTOList //
        .forEach((aquariumDTO) => aquariumDTO.fishDTOList.removeWhere((fishDTO) => fishDTO.id == fishId));

    // aquariumDTOList
    //     .firstWhere((e) => e.id == aquariumId) //
    //     .fishDTOList //
    //     .removeWhere((e) => e.id == fishId);

    aquariumDTOList
        .firstWhere((e) => e.id == aquariumId) //
        .fishDTOList //
        .add(fishDTO);

    state = MainModel(aquariumDTOList: aquariumDTOList);

    mySnackbar(1000, mySnackbarRow1("${fishDTO.name}", " 수정하였습니다.", "", ""));
  }

  Future<void> notifyAquariumCreate(AquariumRequestDTO aquariumRequestDTO, File? imageFile) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchAquariumCreate(sessionUser.jwt!, aquariumRequestDTO, imageFile);

    if (responseDTO.success == false) {
      print("업데이트실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }

    AquariumDTO newAquariumDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    aquariumDTOList.add(newAquariumDTO);

    state = MainModel(aquariumDTOList: aquariumDTOList);

    ref.read(detailOtherProvider.notifier).notifyInit();

    Navigator.pop(mContext!);

    mySnackbar(1000, mySnackbarRow1("${newAquariumDTO.title}", " 생성하였습니다.", "", ""));
  }

  Future<void> notifyAquariumUpdate(int aquariumId, AquariumRequestDTO aquariumRequestDTO, File? imageFile) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchAquariumUpdate(sessionUser.jwt!, aquariumId, aquariumRequestDTO, imageFile);

    if (responseDTO.success == false) {
      print("업데이트실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }

    AquariumDTO newAquariumDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    int index = aquariumDTOList.indexWhere((element) => element.id == newAquariumDTO.id);
    aquariumDTOList[index] = newAquariumDTO;

    state = MainModel(aquariumDTOList: aquariumDTOList);

    ref.read(detailOtherProvider.notifier).notifyInit();

    mySnackbar(1000, mySnackbarRow1("${newAquariumDTO.title}", " 수정하였습니다.", "", ""));
  }

//
}

final mainProvider = StateNotifierProvider.autoDispose<MainViewModel, MainModel?>((ref) {
  // Logger().d("Main 뷰모델");
  // return new MainViewModel(ref, null)..notifyInit();
  return new MainViewModel(ref, null);
});
