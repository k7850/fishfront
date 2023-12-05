import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/board_request_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/ui/board/board_create_page/board_create_view_model.dart';
import 'package:fishfront/ui/board/board_page/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';

class BoardCreateSubmitButton extends ConsumerWidget {
  const BoardCreateSubmitButton(this._formKey, {super.key});

  final _formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BoardCreateModel model = ref.watch(boardCreateProvider)!;

    File? videoFile = model.videoFile;

    TextEditingController title = model.title;
    TextEditingController text = model.text;

    List<File>? imageFileList = model.imageFileList;

    print("바디 ${imageFileList}");

    AquariumDTO? aquariumDTO = model.aquariumDTO;
    FishDTO? fishDTO = model.fishDTO;

    return SizedBox(
      width: sizeGetScreenWidth(context),
      child: ElevatedButton(
        onPressed: () async {
          print("작성완료 누름");
          if (_formKey.currentState!.validate()) {
            BoardRequestDTO boardRequestDTO = BoardRequestDTO(
              title: title.text,
              text: text.text,
              aquariumId: aquariumDTO == null ? -1 : aquariumDTO.id,
              fishId: fishDTO == null ? -1 : fishDTO.id,
            );
            await ref.watch(boardProvider.notifier).notifyBoardCreate(boardRequestDTO, imageFileList, videoFile);
          }
        },
        child: const Text("작성완료"),
      ),
    );
  }
}
