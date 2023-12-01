import 'dart:io';

import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/aquarium_request_dto.dart';
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

class AquariumCreateModel {
  // AquariumDTO aquariumDTO;
  TextEditingController title;
  TextEditingController intro;
  TextEditingController size1;
  TextEditingController size2;
  TextEditingController size3;
  File? imageFile;
  bool isFreshWater;
  Map<int, TextEditingController> controllerMap;
  List<EquipmentDTO> equipmentDTOList;

  AquariumCreateModel.copy(AquariumCreateModel copyState)
      // : aquariumDTO = copyState.aquariumDTO,
      : title = copyState.title,
        intro = copyState.intro,
        size1 = copyState.size1,
        size2 = copyState.size2,
        size3 = copyState.size3,
        imageFile = copyState.imageFile,
        isFreshWater = copyState.isFreshWater,
        controllerMap = copyState.controllerMap,
        equipmentDTOList = copyState.equipmentDTOList;

  AquariumCreateModel({
    // required this.aquariumDTO,
    required this.title,
    required this.intro,
    required this.size1,
    required this.size2,
    required this.size3,
    this.imageFile,
    required this.isFreshWater,
    required this.controllerMap,
    required this.equipmentDTOList,
  });
}

class AquariumCreateViewModel extends StateNotifier<AquariumCreateModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  AquariumCreateViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("피시크리에이트노티파이어인잇");

    TextEditingController title = TextEditingController();
    TextEditingController intro = TextEditingController();
    TextEditingController size1 = TextEditingController();
    TextEditingController size2 = TextEditingController();
    TextEditingController size3 = TextEditingController();

    List<EquipmentDTO> equipmentDTOList = [];

    Map<int, TextEditingController> controllerMap = {};

    state = await AquariumCreateModel(
      // aquariumDTO: aquariumDTO,
      title: title,
      intro: intro,
      size1: size1,
      size2: size2,
      size3: size3,
      imageFile: null,
      isFreshWater: true,
      controllerMap: controllerMap,
      equipmentDTOList: equipmentDTOList,
    );
  }

  Future<void> notifyImageFile(File imageFile) async {
    print("notifyImageFile : ${imageFile}");

    AquariumCreateModel copyState = state!;
    copyState.imageFile = imageFile;
    state = AquariumCreateModel.copy(copyState);
  }

  Future<void> notifyIsFreshWater(bool isFreshWater) async {
    print("notifyIsFreshWater : ${isFreshWater}");

    AquariumCreateModel copyState = state!;
    copyState.isFreshWater = isFreshWater;
    state = AquariumCreateModel.copy(copyState);
  }

  Future<void> notifyTitle(String str) async {
    print("notify : ${str}");

    AquariumCreateModel copyState = state!;
    copyState.title.text = str;
    state = AquariumCreateModel.copy(copyState);
  }

  Future<void> notifyIntro(String str) async {
    print("notify : ${str}");

    AquariumCreateModel copyState = state!;
    copyState.intro.text = str;
    state = AquariumCreateModel.copy(copyState);
  }

  Future<void> notifySize1(String str) async {
    print("notify : ${str}");

    AquariumCreateModel copyState = state!;
    copyState.size1.text = str;
    state = AquariumCreateModel.copy(copyState);
  }

  Future<void> notifySize2(String str) async {
    print("notify : ${str}");

    AquariumCreateModel copyState = state!;
    copyState.size2.text = str;
    state = AquariumCreateModel.copy(copyState);
  }

  Future<void> notifySize3(String str) async {
    print("notify : ${str}");

    AquariumCreateModel copyState = state!;
    copyState.size3.text = str;
    state = AquariumCreateModel.copy(copyState);
  }

  Future<void> notifyEquipmentUpdate(int id, String str) async {
    print("notifyEquipment : ${id}, ${str}");

    AquariumCreateModel copyState = state!;

    copyState.controllerMap[id]!.text = str;

    copyState.equipmentDTOList.firstWhere((element) => element.id == id).name = str;

    state = AquariumCreateModel.copy(copyState);
  }

  Future<void> notifyEquipmentDelete(int id) async {
    print("notifyEquipmentDelete : ${id}");

    AquariumCreateModel copyState = state!;

    copyState.equipmentDTOList.removeWhere((element) => element.id == id);

    copyState.controllerMap[id]!.dispose();
    copyState.controllerMap.remove(id);

    state = AquariumCreateModel.copy(copyState);
  }

  Future<void> notifyEquipmentCreate(String category) async {
    print("notifyEquipmentCreate : ${category}");

    AquariumCreateModel copyState = state!;

    DateTime nowTime = DateTime.now();
    int tempId = -(int.parse(nowTime.millisecondsSinceEpoch.toString().substring(7)));
    print("tempId : $tempId");

    copyState.controllerMap.addAll({tempId: new TextEditingController(text: "")});

    copyState.equipmentDTOList.add(new EquipmentDTO(tempId, -1, category, "", nowTime, nowTime));

    state = AquariumCreateModel.copy(copyState);
  }

  @override
  void dispose() {
    print("피시업데이트 디스포즈됨");

    state!.title.dispose();
    state!.intro.dispose();
    state!.size1.dispose();
    state!.size2.dispose();
    state!.size3.dispose();

    state!.controllerMap.forEach((key, value) => value.dispose());
    // for (var entry in state!.controllerMap.entries) {
    //   entry.value.dispose();
    // }

    super.dispose();
  }

//
}

final aquariumCreateProvider = StateNotifierProvider.autoDispose<AquariumCreateViewModel, AquariumCreateModel?>((ref) {
  // return new DetailOtherViewModel(ref, null)..notifyInit();
  return new AquariumCreateViewModel(ref, null);
});
