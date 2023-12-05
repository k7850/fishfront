import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_aquariuminfo.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_comment.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_fishinfo.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_middle.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_top.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    print("BoardDetailBody 빌드1");

    return ListView(
      children: [
        const BoardDetailTop(),
        const Divider(color: Colors.grey, height: 1, thickness: 1),

        //
        if (boardDTO.video != null && boardDTO.video!.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FlickVideoPlayer(flickManager: flickManager!),
          ),

        //
        if (boardDTO.photoList.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 15),
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
                          width: sizeGetScreenWidth(context),
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

        //
        BoardDetailMiddle(boardDTO: boardDTO),

        //
        if (boardDTO.aquariumDTO != null) const Divider(color: Colors.grey, height: 1, thickness: 1),
        if (boardDTO.aquariumDTO != null) BoardDetailAquariumInfo(aquariumDTO: boardDTO.aquariumDTO!),

        //
        if (boardDTO.fishDTO != null) const Divider(color: Colors.grey, height: 1, thickness: 1),
        if (boardDTO.fishDTO != null) BoardDetailFishInfo(fishDTO: boardDTO.fishDTO!),

        //
        if (boardDTO.commentDTOList.isNotEmpty) const Divider(color: Colors.grey, height: 1, thickness: 1),
        if (boardDTO.commentDTOList.isNotEmpty) BoardDetailComment(commentDTOList: boardDTO.commentDTOList),
      ],
    );
  }
}
