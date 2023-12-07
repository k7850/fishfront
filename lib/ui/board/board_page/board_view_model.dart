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
  int page;
  bool isLastPage;
  TextEditingController controller;
  bool isSearch;

  BoardModel(
      {required this.boardMainDTOList, this.isPhoto, required this.page, required this.isLastPage, required this.controller, required this.isSearch});
}

class BoardViewModel extends StateNotifier<BoardModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  BoardViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("메인보드노티파이어인잇");
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await BoardRepository().fetchBoardMainList(sessionUser.jwt!, 0, "");

    if (responseDTO.success == false) {
      print("notifyInit실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }

    TextEditingController controller = new TextEditingController();

    state = BoardModel(boardMainDTOList: responseDTO.data, isPhoto: null, page: 0, isLastPage: false, controller: controller, isSearch: false);
  }

  Future<void> notifyInitSearch() async {
    print("notifyInitSearch");
    SessionUser sessionUser = ref.read(sessionProvider);

    String keyword = state!.controller.text;

    ResponseDTO responseDTO = await BoardRepository().fetchBoardMainList(sessionUser.jwt!, 0, keyword);

    if (responseDTO.success == false) {
      print("notifyInitSearch 실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }
    List<BoardMainDTO> boardMainDTOList = responseDTO.data;
    bool isLastPage = false;
    if (boardMainDTOList.length < 10) isLastPage = true;

    state = BoardModel(
        boardMainDTOList: boardMainDTOList, isPhoto: state!.isPhoto, page: 0, isLastPage: isLastPage, controller: state!.controller, isSearch: true);
  }

  Future<void> notifyInitAdd() async {
    print("notifyInitAdd");
    SessionUser sessionUser = ref.read(sessionProvider);

    int page = state!.page + 1;
    print("page : $page");

    String keyword = state!.isSearch ? state!.controller.text : "";

    ResponseDTO responseDTO = await BoardRepository().fetchBoardMainList(sessionUser.jwt!, page, keyword);
    // ResponseDTO responseDTO = await BoardRepository().fetchBoardMainList(sessionUser.jwt!, page);

    if (responseDTO.success == false) {
      print("notifyInit실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }
    List<BoardMainDTO> newBoardMainDTOList = responseDTO.data;
    List<BoardMainDTO> boardMainDTOList = state!.boardMainDTOList;

    if (newBoardMainDTOList.isEmpty) {
      print("더 없음");
      state = BoardModel(
        boardMainDTOList: state!.boardMainDTOList,
        isPhoto: state!.isPhoto,
        page: state!.page,
        isLastPage: true,
        controller: state!.controller,
        isSearch: state!.isSearch,
      );
      return;
    }

    print("기존마지막${boardMainDTOList.last.id} / 추가처음${newBoardMainDTOList.first.id}");

    if (boardMainDTOList.last.id == 1 + newBoardMainDTOList.first.id) {
      print("정상적");
      boardMainDTOList.addAll(newBoardMainDTOList);
    } else if (boardMainDTOList.last.id <= newBoardMainDTOList.first.id) {
      print("도중에 글 추가됨");
      for (BoardMainDTO newBoardMainDTO in newBoardMainDTOList) {
        if (newBoardMainDTO.id < boardMainDTOList.last.id) boardMainDTOList.add(newBoardMainDTO);
      }
    } else {
      print("도중에 글 삭제됨");
      // TODO
      boardMainDTOList.addAll(newBoardMainDTOList);
    }

    print("끝");
    state = BoardModel(
      boardMainDTOList: boardMainDTOList,
      isPhoto: state!.isPhoto,
      page: page,
      isLastPage: state!.isLastPage,
      controller: state!.controller,
      isSearch: state!.isSearch,
    );
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

    state = BoardModel(
      boardMainDTOList: boardMainDTOList,
      isPhoto: state!.isPhoto,
      page: state!.page,
      isLastPage: state!.isLastPage,
      controller: state!.controller,
      isSearch: state!.isSearch,
    );
  }

  Future<void> notifyIsPhoto(bool? isPhoto) async {
    print("notifyIsPhoto : ${isPhoto}");

    state = BoardModel(
      boardMainDTOList: state!.boardMainDTOList,
      isPhoto: isPhoto,
      page: state!.page,
      isLastPage: state!.isLastPage,
      controller: state!.controller,
      isSearch: state!.isSearch,
    );
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
  }

  Future<void> notifyBoardDelete(int boardId) async {
    print("notifyBoardDelete : ${boardId}");

    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await BoardRepository().fetchBoardDelete(sessionUser.jwt!, boardId);

    if (responseDTO.success == false) {
      print("notifyBoardDelete 실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }
    BoardMainDTO deleteBoardMainDTO = responseDTO.data;

    Navigator.pop(mContext!);

    mySnackbar(1000, mySnackbarRow1("${deleteBoardMainDTO.title}", " 삭제 완료", "", ""));

    List<BoardMainDTO> boardMainDTOList = state!.boardMainDTOList //
        .where((boardMainDTO) => boardMainDTO.id != deleteBoardMainDTO.id)
        .toList();

    state = BoardModel(
      boardMainDTOList: boardMainDTOList,
      isPhoto: state!.isPhoto,
      page: state!.page,
      isLastPage: state!.isLastPage,
      controller: state!.controller,
      isSearch: state!.isSearch,
    );
  }

  Future<void> notifyDeleteUpdate(int boardId) async {
    print("notifyDeleteUpdate : ${boardId}");

    mySnackbar(1000, mySnackbarRow1("", "삭제된 글입니다.", "", ""));

    Navigator.pop(mContext!);

    List<BoardMainDTO> boardMainDTOList = state!.boardMainDTOList //
        .where((boardMainDTO) => boardMainDTO.id != boardId)
        .toList();

    state = BoardModel(
      boardMainDTOList: boardMainDTOList,
      isPhoto: state!.isPhoto,
      page: state!.page,
      isLastPage: state!.isLastPage,
      controller: state!.controller,
      isSearch: state!.isSearch,
    );
  }

  @override
  void dispose() {
    print("보드메인 디스포즈됨");
    state!.controller.dispose();
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
