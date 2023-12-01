import 'dart:io';

import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/aquarium_request_dto.dart';
import 'package:fishfront/ui/aquarium/detail_other_page/detail_other_view_model.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/dto/equipment_dto.dart';

class DetailOtherButton extends ConsumerWidget {
  final _formKey;

  const DetailOtherButton(this._formKey, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailOtherModel model = ref.watch(detailOtherProvider)!;

    AquariumDTO aquariumDTO = model.aquariumDTO;

    TextEditingController _title = model.title;
    TextEditingController _intro = model.intro;
    TextEditingController _size1 = model.size1;
    TextEditingController _size2 = model.size2;
    TextEditingController _size3 = model.size3;

    File? imageFile = model.imageFile;
    bool isFreshWater = model.isFreshWater;

    List<EquipmentDTO> equipmentDTOList = model.equipmentDTOList;

    return ElevatedButton(
      onPressed: () async {
        print("제출 누름");
        if (_formKey.currentState!.validate()) {
          AquariumRequestDTO aquariumRequestDTO = AquariumRequestDTO(
            title: _title.text,
            intro: _intro.text,
            size: "${_size1.text}/${_size2.text}/${_size3.text}",
            isFreshWater: isFreshWater,
            photo: aquariumDTO.photo,
            equipmentDTOList: equipmentDTOList,
          );

          await ref.watch(mainProvider.notifier).notifyAquariumUpdate(aquariumDTO.id, aquariumRequestDTO, imageFile);
        }
      },
      child: const Text("제출하기"),
    );
  }
}
