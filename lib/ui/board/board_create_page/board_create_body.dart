import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/board_request_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/ui/_common_widgets/aquarium_textformfield.dart';
import 'package:fishfront/ui/_common_widgets/select_aquarium.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/widgets/fish_update_alertdialog.dart';
import 'package:fishfront/ui/board/board_create_page/board_create_view_model.dart';
import 'package:fishfront/ui/board/board_create_page/widgets/board_create_selectfish.dart';
import 'package:fishfront/ui/board/board_page/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flick_video_player/flick_video_player.dart';

import 'dart:convert';
import 'dart:io';

import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

  // @override
  // void didChangeDependencies() {
  //   print("BoardDetailBody didChangeDependencies");
  //
  //   model = ref.watch(boardCreateProvider)!;
  //   videoFile = model.videoFile;
  //
  //   // if (videoFile != null) {
  //   //   videoController = VideoPlayerController.file(videoFile!)..initialize();
  //   //   flickManager = FlickManager(videoPlayerController: videoController!);
  //   // }
  //
  //   super.didChangeDependencies();
  // }

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

    List<File>? imageFileList = model.imageFileList;

    AquariumDTO? aquariumDTO = model.aquariumDTO;
    FishDTO? fishDTO = model.fishDTO;

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const SizedBox(height: 15),
          if (videoFile != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FlickVideoPlayer(flickManager: flickManager!),
            ),
          if (imageFileList != null)
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: new PageController(viewportFraction: 0.93),
                pageSnapping: true,
                itemCount: imageFileList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Stack(
                      alignment: const Alignment(0.9, 0.9),
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            imageFileList[index],
                            height: 300,
                            width: sizeGetScreenWidth(context),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(5))),
                          padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                          child: Text(
                            "${index + 1} / ${imageFileList.length}",
                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: const Text("사진 등록"),
                        onPressed: () async {
                          ref.read(boardCreateProvider.notifier).notifyImageFileList(null);
                          ref.read(boardCreateProvider.notifier).notifyVideoFile(null);
                          final List<XFile> imageList = await ImagePicker().pickMultiImage();
                          if (imageList.isEmpty) return;

                          List<File> imageFileList = [];
                          for (XFile image in imageList) {
                            imageFileList.add(File(image.path));
                          }
                          ref.read(boardCreateProvider.notifier).notifyImageFileList(imageFileList);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text("동영상 등록"),
                        onPressed: () async {
                          ref.read(boardCreateProvider.notifier).notifyVideoFile(null);
                          ref.read(boardCreateProvider.notifier).notifyImageFileList(null);
                          XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
                          if (video == null) return;
                          ref.read(boardCreateProvider.notifier).notifyVideoFile(File(video.path));
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 13, bottom: 2),
                  alignment: const Alignment(-1, 0),
                  child: Text("글 제목", style: TextStyle(color: Colors.grey[600])),
                ),
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Color.fromRGBO(210, 210, 210, 1),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                  ),
                  controller: title,
                  validator: (value) {
                    return validateNormal()(value); // String?을 입력으로 받아서 String?을 반환하는 함수를 적어야 함
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 13, bottom: 2),
                  alignment: const Alignment(-1, 0),
                  child: Text("글 내용", style: TextStyle(color: Colors.grey[600])),
                ),
                TextFormField(
                  maxLines: 7,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Color.fromRGBO(210, 210, 210, 1),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                  ),
                  controller: text,
                  validator: (value) {
                    return validateLong()(value); // String?을 입력으로 받아서 String?을 반환하는 함수를 적어야 함
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 13, bottom: 2),
                  alignment: const Alignment(-1, 0),
                  child: Text("어항 연동", style: TextStyle(color: Colors.grey[600])),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SelectAquarium(mainText: "연동");
                      },
                    );
                  },
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color.fromRGBO(210, 210, 210, 1)),
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, left: 5),
                        child: Text(aquariumDTO == null ? "" : aquariumDTO.title, style: const TextStyle(fontSize: 17)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 13, bottom: 2),
                  alignment: const Alignment(-1, 0),
                  child: Text("생물 연동", style: TextStyle(color: Colors.grey[600])),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SelectFish();
                      },
                    );
                  },
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color.fromRGBO(210, 210, 210, 1)),
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, left: 5),
                        child: Text(fishDTO == null ? "" : fishDTO.name, style: const TextStyle(fontSize: 17)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
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
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
