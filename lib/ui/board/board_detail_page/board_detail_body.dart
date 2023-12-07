import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_aquariuminfo.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_comment.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_fishinfo.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_middle.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_pageview.dart';
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
        // 글 정보
        const BoardDetailTop(),
        const Divider(color: Colors.grey, height: 1, thickness: 1),

        // 비디오
        if (boardDTO.video != null && boardDTO.video!.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FlickVideoPlayer(flickManager: flickManager!),
          ),

        // 사진 페이지뷰
        if (boardDTO.photoList.isNotEmpty) BoardDetailPageView(boardDTO: boardDTO),

        // 글내용+이모티콘
        const BoardDetailMiddle(),
        const Divider(color: Colors.grey, height: 1, thickness: 1),

        // 연동어항
        if (boardDTO.aquariumDTO != null) BoardDetailAquariumInfo(aquariumDTO: boardDTO.aquariumDTO!),
        if (boardDTO.aquariumDTO != null) const Divider(color: Colors.grey, height: 1, thickness: 1),

        // 연동생물
        if (boardDTO.fishDTO != null) BoardDetailFishInfo(fishDTO: boardDTO.fishDTO!),
        if (boardDTO.fishDTO != null) const Divider(color: Colors.grey, height: 1, thickness: 1),

        // 댓글
        const BoardDetailComment(),

        // 댓글 쓰는 바텀시트 높이만큼
        const SizedBox(height: 50),
      ],
    );
  }
}
