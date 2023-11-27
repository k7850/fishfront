import 'dart:io';

import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/fish_request_dto.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/dto/schedule_request_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/data/repository/aquarium_repository.dart';
import 'package:fishfront/data/repository/board_repository.dart';
import 'package:fishfront/data/repository/book_repository.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class BookModel {
  List<Book> bookList;

  BookModel({required this.bookList});
}

class BookViewModel extends StateNotifier<BookModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  BookViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("메인북노티파이어인잇");
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await BookRepository().fetchBookList(sessionUser.jwt!);

    if (responseDTO.success == false) {
      print("notifyInit실패 : ${responseDTO}");
      mySnackbar(1000, mySnackbarRow1("", "${responseDTO.errorType}", "", ""));
      notifyInit();
      return;
    }

    state = BookModel(bookList: responseDTO.data);
  }

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

//
}

final bookProvider = StateNotifierProvider.autoDispose<BookViewModel, BookModel?>((ref) {
  // Logger().d("Book 뷰모델");
  // return new BookViewModel(ref, null)..notifyInit();
  return new BookViewModel(ref, null);
});
