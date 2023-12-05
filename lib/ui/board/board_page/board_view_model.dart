import 'dart:io';

import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/data/dto/board_main_dto.dart';
import 'package:fishfront/data/dto/board_request_dto.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/data/repository/board_repository.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/board/board_detail_page/board_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardModel {
  List<BoardMainDTO> boardMainDTOList;

  bool? isPhoto;

  BoardModel({required this.boardMainDTOList, this.isPhoto});
}

class BoardViewModel extends StateNotifier<BoardModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  BoardViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("메인보드노티파이어인잇");
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await BoardRepository().fetchBoardMainList(sessionUser.jwt!);

    if (responseDTO.success == false) {
      print("notifyInit실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }

    state = BoardModel(boardMainDTOList: responseDTO.data);
  }

  Future<void> notifyView(BoardDTO boardDTO) async {
    print("notifyView");

    List<BoardMainDTO> boardMainDTOList = state!.boardMainDTOList;

    for (BoardMainDTO boardMainDTO in boardMainDTOList) {
      if (boardMainDTO.id == boardDTO.id) {
        boardMainDTO.viewCount = boardDTO.viewCount;
        boardMainDTO.isView = true;
      }
    }

    state = BoardModel(boardMainDTOList: boardMainDTOList, isPhoto: state!.isPhoto);
  }

  Future<void> notifyIsPhoto(bool? isPhoto) async {
    print("notifyIsPhoto : ${isPhoto}");

    state = BoardModel(boardMainDTOList: state!.boardMainDTOList, isPhoto: isPhoto);
  }

  Future<void> notifyBoardCreate(BoardRequestDTO boardRequestDTO, List<File>? imageFileList, File? videoFile) async {
    print("notifyBoardCreate : ${boardRequestDTO}");

    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await BoardRepository().fetchBoardCreate(sessionUser.jwt!, boardRequestDTO, imageFileList, videoFile);

    if (responseDTO.success == false) {
      print("notifyBoardCreate실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }
    BoardDTO boardDTO = responseDTO.data;

    mySnackbar(1000, mySnackbarRow1("${boardDTO.title}", " 작성 완료", "", ""));

    ParamStore paramStore = ref.read(paramProvider);
    paramStore.addBoardDetailId(boardDTO.id);
    Navigator.pushReplacement(mContext!, MaterialPageRoute(builder: (_) => const BoardDetailPage()));

    notifyInit();
    // state = BoardModel(boardMainDTOList: state!.boardMainDTOList, isPhoto: state!.isPhoto);
  }

  // Future<void> notifyFishClassEnum(FishClassEnum fishClassEnum) async {
  //   print("notifyFishClassEnum : ${fishClassEnum}");
  //
  //   // state!.fishClassEnum = fishClassEnum;
  //   state =
  //       BoardModel(bookList: state!.bookList, isFreshWater: state!.isFreshWater, fishClassEnum: fishClassEnum, newSearchTerm: state!.newSearchTerm);
  // }
  //
  // Future<void> notifySearch(String newSearchTerm) async {
  //   print("notifySearch : ${newSearchTerm}");
  //
  //   state =
  //       BoardModel(bookList: state!.bookList, isFreshWater: state!.isFreshWater, fishClassEnum: state!.fishClassEnum, newSearchTerm: newSearchTerm);
  // }

  // Future<List<Book>?> notifyBookList() async {
  //   SessionUser sessionUser = ref.read(sessionProvider);
  //
  //   ResponseDTO responseDTO = await BookRepository().fetchBookList(sessionUser.jwt!);
  //
  //   if (responseDTO.success == false) {
  //     print("notifyBookList실패 : ${responseDTO}");
  //     mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
  //     notifyInit();
  //     return null;
  //   }
  //
  //   List<Book> bookList = responseDTO.data;
  //
  //   return bookList;
  // }

  @override
  void dispose() {
    print("보드메인 디스포즈됨");
    super.dispose();
  }

//
}

final boardProvider = StateNotifierProvider.autoDispose<BoardViewModel, BoardModel?>((ref) {
// final boardProvider = StateNotifierProvider<BoardViewModel, BoardModel?>((ref) {
  // Logger().d("Book 뷰모델");
  // return new BookViewModel(ref, null)..notifyInit();
  return new BoardViewModel(ref, null);
});
