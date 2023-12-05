import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/ui/_common_widgets/subTitle.dart';
import 'package:fishfront/ui/board/board_create_page/board_create_view_model.dart';
import 'package:fishfront/ui/board/board_create_page/widgets/board_create_filebuttons.dart';
import 'package:fishfront/ui/board/board_create_page/widgets/board_create_photolist.dart';
import 'package:fishfront/ui/board/board_create_page/widgets/board_create_select_aquarium.dart';
import 'package:fishfront/ui/board/board_create_page/widgets/board_create_select_fish.dart';
import 'package:fishfront/ui/board/board_create_page/widgets/board_create_submitbutton.dart';
import 'package:fishfront/ui/board/board_create_page/widgets/board_create_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flick_video_player/flick_video_player.dart';

import 'dart:io';

import 'package:fishfront/_core/utils/validator_util.dart';

import 'package:video_player/video_player.dart';

class BoardCreateBody extends ConsumerStatefulWidget {
  const BoardCreateBody({super.key});

  @override
  _BoardCreateBodyState createState() => _BoardCreateBodyState();
}

class _BoardCreateBodyState extends ConsumerState<BoardCreateBody> {
  final _formKey = GlobalKey<FormState>();

  VideoPlayerController? videoController;
  FlickManager? flickManager;

  late BoardCreateModel model;

  late File? videoFile;

  @override
  void dispose() {
    print("BoardCreateBody 디스포즈");
    if (videoController != null) videoController?.dispose();
    if (flickManager != null) flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("BoardCreateBody 빌드");

    model = ref.watch(boardCreateProvider)!;

    videoFile = model.videoFile;

    if (videoFile != null) {
      videoController = VideoPlayerController.file(videoFile!)..initialize();
      flickManager = FlickManager(videoPlayerController: videoController!);
    }

    TextEditingController title = model.title;
    TextEditingController text = model.text;

    AquariumDTO? aquariumDTO = model.aquariumDTO;
    FishDTO? fishDTO = model.fishDTO;

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const SizedBox(height: 15),
          videoFile != null
              ? Container(padding: const EdgeInsets.symmetric(horizontal: 20), child: FlickVideoPlayer(flickManager: flickManager!))
              : const SizedBox(),
          const BoardCreatePhotoList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const BoardCreateFileButtons(),
                const SubTitle(subTitle: "글 제목"),
                BoardCreateTextFormField(controller: title, validate: validateNormal()),
                const SubTitle(subTitle: "글 내용"),
                BoardCreateTextFormField(controller: text, validate: validateLong(), maxLine: 7),
                const SubTitle(subTitle: "어항 연동"),
                BoardCreateSelectAquarium(aquariumDTO: aquariumDTO),
                const SubTitle(subTitle: "생물 연동"),
                BoardCreateSelectFish(fishDTO: fishDTO),
                const SizedBox(height: 10),
                BoardCreateSubmitButton(_formKey),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
