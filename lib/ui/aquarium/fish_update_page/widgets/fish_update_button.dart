import 'dart:io';

import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/fish_request_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/fish_update_view_model.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishUpdateButton extends ConsumerWidget {
  final _formKey;

  const FishUpdateButton(this._formKey, {super.key});

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
          FishRequestDTO fishRequestDTO = FishRequestDTO(
            fishClassEnum: fishClassEnum,
            name: _name.text,
            text: _text.text,
            quantity: quantity,
            isMale: isMale,
            photo: photo,
            price: _price.text,
            bookId: book?.id,
          );

          await ref.watch(mainProvider.notifier).notifyFishUpdate(aquariumDTO.id, fishDTO.id, fishRequestDTO, imageFile);
        }
      },
      child: const Text("제출하기"),
    );
  }
}
