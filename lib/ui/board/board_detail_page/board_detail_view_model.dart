import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/data/dto/board_main_dto.dart';
import 'package:fishfront/data/dto/comment_dto.dart';
import 'package:fishfront/data/dto/comment_request_dto.dart';
import 'package:fishfront/data/dto/emoticon_dto.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/data/repository/board_repository.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/board/board_page/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardDetailModel {
  BoardDTO boardDTO;

  BoardDetailModel({required this.boardDTO});
}

class BoardDetailViewModel extends StateNotifier<BoardDetailModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  BoardDetailViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("보드디테일 노티파이어인잇");
    SessionUser sessionUser = ref.read(sessionProvider);
    int boardId = ref.read(paramProvider).boardDetailId!;

    ResponseDTO responseDTO = await BoardRepository().fetchBoard(sessionUser.jwt!, boardId);

    if (responseDTO.success == false) {
      try {
        if (responseDTO.errorType!.msg!.contains("없음")) {
          print("notifyInit실패 : ${responseDTO}");
          ref.read(boardProvider.notifier).notifyDeleteUpdate(boardId);
          return;
        }
      } catch (e) {
        print("notifyInit실패 : ${responseDTO}");
        mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
        // notifyInit();
        return;
      }
    }

    BoardDTO boardDTO = responseDTO.data;

    ref.read(boardProvider.notifier).notifyView(boardDTO);

    state = BoardDetailModel(boardDTO: boardDTO);
  }

  Future<void> notifyCommentCreate(CommentRequestDTO commentRequestDTO) async {
    print("notifyCommentCreate : ${commentRequestDTO}");

    SessionUser sessionUser = ref.read(sessionProvider);

    BoardDTO boardDTO = state!.boardDTO;

    ResponseDTO responseDTO = await BoardRepository().fetchCommentCreate(sessionUser.jwt!, commentRequestDTO, boardDTO.id);

    if (responseDTO.success == false) {
      print("notifyCommentCreate실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }
    CommentDTO commentDTO = responseDTO.data;

    mySnackbar(1000, mySnackbarRow1("댓글", " 작성 완료", "", ""));

    List<BoardMainDTO> boardMainDTOList = ref.read(boardProvider)!.boardMainDTOList;

    boardMainDTOList.firstWhere((element) => element.id == boardDTO.id).commentCount++;

    // notifyInit();

    boardDTO.commentDTOList.insert(0, commentDTO);

    state = BoardDetailModel(boardDTO: boardDTO);
  }

  Future<void> notifyCommentDelete(int commentId) async {
    print("notifyCommentDelete : ${commentId}");

    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await BoardRepository().fetchCommentDelete(sessionUser.jwt!, commentId);

    if (responseDTO.success == false) {
      print("notifyCommentDelete 실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }
    CommentDTO deleteCommentDTO = responseDTO.data;

    mySnackbar(1000, mySnackbarRow1("댓글", " 삭제 완료", "", ""));

    // notifyInit();

    BoardDTO boardDTO = state!.boardDTO;

    boardDTO.commentDTOList.firstWhere((element) => element.id == deleteCommentDTO.id).isDelete = true;

    state = BoardDetailModel(boardDTO: boardDTO);
  }

  Future<void> notifyLikeComment(int commentId, bool isLike) async {
    print("notifyLikeComment : ${commentId}");
    print("isLike : ${isLike}");

    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await BoardRepository().fetchLikeComment(sessionUser.jwt!, commentId, isLike);

    if (responseDTO.success == false) {
      print("notifyLikeComment 실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }
    CommentDTO newCommentDTO = responseDTO.data;

    BoardDTO boardDTO = state!.boardDTO;

    // List<CommentDTO> newList = [];
    // for (CommentDTO commentDTO in boardDTO.commentDTOList) {
    //   if (commentDTO.id == newCommentDTO.id) {
    //     newList.add(newCommentDTO);
    //   } else {
    //     newList.add(commentDTO);
    //   }
    // }

    List<CommentDTO> newList = boardDTO.commentDTOList.map((commentDTO) {
      return commentDTO.id == newCommentDTO.id ? newCommentDTO : commentDTO;
    }).toList();

    boardDTO.commentDTOList = newList;

    state = BoardDetailModel(boardDTO: boardDTO);
  }

  Future<void> notifyLikeCommentDelete(int commentId) async {
    print("notifyLikeCommentDelete : ${commentId}");

    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await BoardRepository().fetchLikeCommentDelete(sessionUser.jwt!, commentId);

    if (responseDTO.success == false) {
      print("notifyLikeCommentDelete 실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }
    CommentDTO newCommentDTO = responseDTO.data;

    BoardDTO boardDTO = state!.boardDTO;

    // List<CommentDTO> newList = [];
    // for (CommentDTO commentDTO in boardDTO.commentDTOList) {
    //   if (commentDTO.id == newCommentDTO.id) {
    //     newList.add(newCommentDTO);
    //   } else {
    //     newList.add(commentDTO);
    //   }
    // }

    List<CommentDTO> newList = boardDTO.commentDTOList.map((commentDTO) {
      return commentDTO.id == newCommentDTO.id ? newCommentDTO : commentDTO;
    }).toList();

    boardDTO.commentDTOList = newList;

    state = BoardDetailModel(boardDTO: boardDTO);
  }

  Future<void> notifyEmoticonDelete(EmoticonEnum emoticonEnum, int boardId) async {
    print("notifyEmoticonDelete : ${emoticonEnum}");

    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await BoardRepository().fetchEmoticonDelete(sessionUser.jwt!, emoticonEnum, boardId);

    if (responseDTO.success == false) {
      print("notifyEmoticonDelete 실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }
    EmoticonDTO emoticonDTO = responseDTO.data;

    // mySnackbar(1000, mySnackbarRow1("댓글", " 삭제 완료", "", ""));

    // notifyInit();

    BoardDTO boardDTO = state!.boardDTO;

    boardDTO.emoticonCount.myEmoticonEnum = null;

    if (emoticonDTO.deleteEmoticon == EmoticonEnum.SMILE) boardDTO.emoticonCount.countSMILE--;
    if (emoticonDTO.deleteEmoticon == EmoticonEnum.CONGRATATU) boardDTO.emoticonCount.countCONGRATATU--;
    if (emoticonDTO.deleteEmoticon == EmoticonEnum.THUMB) boardDTO.emoticonCount.countTHUMB--;
    if (emoticonDTO.deleteEmoticon == EmoticonEnum.ANGRY) boardDTO.emoticonCount.countANGRY--;
    if (emoticonDTO.deleteEmoticon == EmoticonEnum.CRY) boardDTO.emoticonCount.countCRY--;
    if (emoticonDTO.deleteEmoticon == EmoticonEnum.HEART) boardDTO.emoticonCount.countHEART--;

    state = BoardDetailModel(boardDTO: boardDTO);
  }

  Future<void> notifyEmoticon(EmoticonEnum emoticonEnum, int boardId) async {
    print("notifyEmoticon : ${emoticonEnum}");

    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await BoardRepository().fetchEmoticon(sessionUser.jwt!, emoticonEnum, boardId);

    if (responseDTO.success == false) {
      print("notifyEmoticon 실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }
    EmoticonDTO emoticonDTO = responseDTO.data;

    // mySnackbar(1000, mySnackbarRow1("댓글", " 삭제 완료", "", ""));

    // notifyInit();

    BoardDTO boardDTO = state!.boardDTO;

    boardDTO.emoticonCount.myEmoticonEnum = emoticonDTO.createEmoticon;

    if (emoticonDTO.deleteEmoticon == EmoticonEnum.SMILE) boardDTO.emoticonCount.countSMILE--;
    if (emoticonDTO.deleteEmoticon == EmoticonEnum.CONGRATATU) boardDTO.emoticonCount.countCONGRATATU--;
    if (emoticonDTO.deleteEmoticon == EmoticonEnum.THUMB) boardDTO.emoticonCount.countTHUMB--;
    if (emoticonDTO.deleteEmoticon == EmoticonEnum.ANGRY) boardDTO.emoticonCount.countANGRY--;
    if (emoticonDTO.deleteEmoticon == EmoticonEnum.CRY) boardDTO.emoticonCount.countCRY--;
    if (emoticonDTO.deleteEmoticon == EmoticonEnum.HEART) boardDTO.emoticonCount.countHEART--;

    if (emoticonDTO.createEmoticon == EmoticonEnum.SMILE) boardDTO.emoticonCount.countSMILE++;
    if (emoticonDTO.createEmoticon == EmoticonEnum.CONGRATATU) boardDTO.emoticonCount.countCONGRATATU++;
    if (emoticonDTO.createEmoticon == EmoticonEnum.THUMB) boardDTO.emoticonCount.countTHUMB++;
    if (emoticonDTO.createEmoticon == EmoticonEnum.ANGRY) boardDTO.emoticonCount.countANGRY++;
    if (emoticonDTO.createEmoticon == EmoticonEnum.CRY) boardDTO.emoticonCount.countCRY++;
    if (emoticonDTO.createEmoticon == EmoticonEnum.HEART) boardDTO.emoticonCount.countHEART++;

    state = BoardDetailModel(boardDTO: boardDTO);
  }

  @override
  void dispose() {
    print("보드디테일 디스포즈됨");
    super.dispose();
  }

//
}

final boardDetailProvider = StateNotifierProvider.autoDispose<BoardDetailViewModel, BoardDetailModel?>((ref) {
// final boardProvider = StateNotifierProvider<BoardViewModel, BoardModel?>((ref) {
  // Logger().d("Book 뷰모델");
  // return new BookViewModel(ref, null)..notifyInit();
  return new BoardDetailViewModel(ref, null);
});
