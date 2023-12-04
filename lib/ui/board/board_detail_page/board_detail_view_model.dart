import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/data/dto/board_main_dto.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/data/repository/board_repository.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/board/board_page/board_view_model.dart';
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
      print("notifyInit실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      // notifyInit();
      return;
    }

    BoardDTO boardDTO = responseDTO.data;

    ref.read(boardProvider.notifier).notifyView(boardDTO);

    state = BoardDetailModel(boardDTO: boardDTO);
  }

  // Future<void> notifyIsAquarium(bool? isAquarium) async {
  //   print("notifyIsAquarium : ${isAquarium}");
  //
  //   // state!.isFreshWater = await isFreshWater;
  //   state = BoardDetailModel(boardMainDTOList: state!.boardMainDTOList, isAquarium: isAquarium);
  // }

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
