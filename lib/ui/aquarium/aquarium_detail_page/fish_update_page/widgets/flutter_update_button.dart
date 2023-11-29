import 'dart:io';

import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/fish_request_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/fish_update_page/fish_update_view_model.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishUpdateButton extends ConsumerWidget {
  final _formKey;

  FishUpdateButton(this._formKey);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FishUpdateModel model = ref.watch(fishUpdateProvider)!;

    FishDTO fishDTO = model.fishDTO;
    AquariumDTO aquariumDTO = model.aquariumDTO;

    TextEditingController _name = model.name;
    TextEditingController _text = model.text;
    TextEditingController _price = model.price;

    FishClassEnum fishClassEnum = model.fishClassEnum;
    int quantity = model.quantity;

    bool? isMale = model.isMale;
    String? photo = model.photo;
    Book? book = model.book;

    File? imageFile = model.imageFile;

    return ElevatedButton(
      onPressed: () async {
        print("fish업뎃 제출하기");
        if (_formKey.currentState!.validate()) {
          print("validate통과");

          FishRequestDTO fishRequestDTO = FishRequestDTO(fishClassEnum, _name.text, _text.text, quantity, isMale, photo, _price.text, book?.id);

          await ref.watch(mainProvider.notifier).notifyFishUpdate(aquariumDTO.id, fishDTO.id, fishRequestDTO, imageFile);
        }
      },
      child: Text("제출하기"),
    );
  }
}
