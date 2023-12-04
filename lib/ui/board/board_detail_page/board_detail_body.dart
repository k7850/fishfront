import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/ui/_common_widgets/select_aquarium.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../_common_widgets/difficulty_string.dart';
import 'board_detail_view_model.dart';

import 'package:video_player/video_player.dart';

class BoardDetailBody extends ConsumerStatefulWidget {
  const BoardDetailBody({super.key});

  @override
  _BoardDetailBodyState createState() => _BoardDetailBodyState();
}

class _BoardDetailBodyState extends ConsumerState<BoardDetailBody> {
  VideoPlayerController? videoController;
  FlickManager? flickManager;

  late BoardDTO boardDTO;

  @override
  void didChangeDependencies() {
    print("BoardDetailBody didChangeDependencies");

    BoardDetailModel model = ref.watch(boardDetailProvider)!;
    boardDTO = model.boardDTO;

    if (boardDTO.video != null && boardDTO.video!.isNotEmpty) {
      videoController = VideoPlayerController.networkUrl(Uri.parse("$videoURL${boardDTO.video}"))..initialize();
      flickManager = FlickManager(videoPlayerController: videoController!);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    print("BoardDetailBody 디스포즈");
    if (videoController != null) videoController?.dispose();
    if (flickManager != null) flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("BoardDetailBody 빌드");

    return ListView(
      children: [
        const SizedBox(height: 15),
        if (boardDTO.video != null && boardDTO.video!.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FlickVideoPlayer(flickManager: flickManager!),
          ),
        if (boardDTO.photoList.length == 1)
          Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "$imageURL${boardDTO.photoList[0]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (boardDTO.photoList.length > 1)
          SizedBox(
            height: 300,
            child: PageView.builder(
              controller: new PageController(viewportFraction: 0.93),
              pageSnapping: true,
              itemCount: boardDTO.photoList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Stack(
                    alignment: const Alignment(0.9, 0.9),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "$imageURL${boardDTO.photoList[index]}",
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                        child: Text(
                          "${index + 1} / ${boardDTO.photoList.length}",
                          style: const TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(boardDTO.username, style: const TextStyle(fontSize: 20)),
        ),
        const SizedBox(height: 5),
        Text("${boardDTO.emoticonCount}", style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 5),
        Text("${boardDTO.text}", style: TextStyle(fontSize: 15, color: Colors.grey[600])),
        const SizedBox(height: 15),
      ],
    );
  }
}
