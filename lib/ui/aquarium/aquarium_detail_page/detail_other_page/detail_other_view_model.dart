import 'dart:io';

import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/equipment_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailOtherModel {
  AquariumDTO aquariumDTO;
  TextEditingController title;
  TextEditingController intro;
  TextEditingController size1;
  TextEditingController size2;
  TextEditingController size3;
  File? imageFile;
  bool isFreshWater;
  Map<int, TextEditingController> controllerMap;
  List<EquipmentDTO> equipmentDTOList;

  DetailOtherModel.Copy(DetailOtherModel CopyState)
      : this.aquariumDTO = CopyState.aquariumDTO,
        this.title = CopyState.title,
        this.intro = CopyState.intro,
        this.size1 = CopyState.size1,
        this.size2 = CopyState.size2,
        this.size3 = CopyState.size3,
        this.imageFile = CopyState.imageFile,
        this.isFreshWater = CopyState.isFreshWater,
        this.controllerMap = CopyState.controllerMap,
        this.equipmentDTOList = CopyState.equipmentDTOList;

  DetailOtherModel({
    required this.aquariumDTO,
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

class DetailOtherViewModel extends StateNotifier<DetailOtherModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  DetailOtherViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("피시업데이트노티파이어인잇");

    ParamStore paramStore = ref.read(paramProvider);

    AquariumDTO aquariumDTO = ref
        .read(mainProvider)! //
        .aquariumDTOList //
        .firstWhere((element) => element.id == paramStore.aquariumDetailId);

    TextEditingController title = TextEditingController(text: "${aquariumDTO.title ?? ""}");
    TextEditingController intro = TextEditingController(text: "${aquariumDTO.intro ?? ""}");
    TextEditingController size1 = TextEditingController(text: "${aquariumDTO.size?.split("/")[0] ?? "0"}");
    TextEditingController size2 = TextEditingController(text: "${aquariumDTO.size?.split("/")[1] ?? "0"}");
    TextEditingController size3 = TextEditingController(text: "${aquariumDTO.size?.split("/")[2] ?? "0"}");

    // List<EquipmentDTO> equipmentDTOList = aquariumDTO.equipmentDTOList;
    List<EquipmentDTO> equipmentDTOList = List.from(aquariumDTO.equipmentDTOList);
    // 깊은 복사
    print("${aquariumDTO.equipmentDTOList.hashCode}");
    print("${equipmentDTOList.hashCode}");

    Map<int, TextEditingController> controllerMap = {};
    for (EquipmentDTO equipment in equipmentDTOList) {
      controllerMap.addAll({equipment.id: new TextEditingController(text: equipment.name)});
    }

    state = await DetailOtherModel(
      aquariumDTO: aquariumDTO,
      title: title,
      intro: intro,
      size1: size1,
      size2: size2,
      size3: size3,
      imageFile: null,
      isFreshWater: aquariumDTO.isFreshWater ?? true,
      controllerMap: controllerMap,
      equipmentDTOList: equipmentDTOList,
    );
  }

  Future<void> notifyImageFile(File imageFile) async {
    print("notifyImageFile : ${imageFile}");

    DetailOtherModel copyState = state!;
    copyState.imageFile = imageFile;
    state = DetailOtherModel.Copy(copyState);
  }

  Future<void> notifyIsFreshWater(bool isFreshWater) async {
    print("notifyIsFreshWater : ${isFreshWater}");

    DetailOtherModel copyState = state!;
    copyState.isFreshWater = isFreshWater;
    state = DetailOtherModel.Copy(copyState);
  }

  Future<void> notifyTitle(String str) async {
    print("notify : ${str}");

    DetailOtherModel copyState = state!;
    copyState.title.text = str;
    state = DetailOtherModel.Copy(copyState);
  }

  Future<void> notifyIntro(String str) async {
    print("notify : ${str}");

    DetailOtherModel copyState = state!;
    copyState.intro.text = str;
    state = DetailOtherModel.Copy(copyState);
  }

  Future<void> notifySize1(String str) async {
    print("notify : ${str}");

    DetailOtherModel copyState = state!;
    copyState.size1.text = str;
    state = DetailOtherModel.Copy(copyState);
  }

  Future<void> notifySize2(String str) async {
    print("notify : ${str}");

    DetailOtherModel copyState = state!;
    copyState.size2.text = str;
    state = DetailOtherModel.Copy(copyState);
  }

  Future<void> notifySize3(String str) async {
    print("notify : ${str}");

    DetailOtherModel copyState = state!;
    copyState.size3.text = str;
    state = DetailOtherModel.Copy(copyState);
  }

  Future<void> notifyEquipmentUpdate(int id, String str) async {
    print("notifyEquipment : ${id}, ${str}");

    DetailOtherModel copyState = state!;

    copyState.controllerMap[id]!.text = str;

    copyState.equipmentDTOList.firstWhere((element) => element.id == id).name = str;

    state = DetailOtherModel.Copy(copyState);
  }

  Future<void> notifyEquipmentDelete(int id) async {
    print("notifyEquipmentDelete : ${id}");

    DetailOtherModel copyState = state!;

    copyState.equipmentDTOList.removeWhere((element) => element.id == id);

    copyState.controllerMap[id]!.dispose();
    copyState.controllerMap.remove(id);

    state = DetailOtherModel.Copy(copyState);
  }

  Future<void> notifyEquipmentCreate(String category) async {
    print("notifyEquipmentCreate : ${category}");

    DetailOtherModel copyState = state!;

    copyState.controllerMap.addAll({-(copyState.equipmentDTOList.length): new TextEditingController(text: "")});
    // 이걸 늦게 하면 equipmentDTOList.length 변경됨.

    copyState.equipmentDTOList
        .add(new EquipmentDTO(-(copyState.equipmentDTOList.length), copyState.aquariumDTO.id, category, "", DateTime.now(), DateTime.now()));

    state = DetailOtherModel.Copy(copyState);
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

final detailOtherProvider = StateNotifierProvider.autoDispose<DetailOtherViewModel, DetailOtherModel?>((ref) {
  // return new DetailOtherViewModel(ref, null)..notifyInit();
  return new DetailOtherViewModel(ref, null);
});
