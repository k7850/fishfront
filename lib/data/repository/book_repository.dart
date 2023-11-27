import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/data/DTO/user_request.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/fish_request_dto.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/dto/schedule_request_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/data/model/user.dart';
import 'package:logger/logger.dart';

// MVVM패턴 : View -> Provider(전역프로바이더or뷰모델) -> Repository(통신+파싱을 책임)
// 나중에 싱글톤으로 바꿀것
class BookRepository {
//

  Future<ResponseDTO> fetchBookList(String jwt) async {
    try {
      Response response = await dio.get("/books", options: Options(headers: {"Authorization": "${jwt}"}));

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      List<dynamic> mapList = responseDTO.data as List<dynamic>;

      List<Book> bookList = mapList.map((book) => Book.fromJson(book)).toList();

      responseDTO.data = bookList;

      return responseDTO;
    } catch (e) {
      if (e is DioError) {
        print("e.response : ${e.response}");
        return new ResponseDTO.fromJson(e.response!.data);
      }
      print("e : ${e}");
      return new ResponseDTO(success: false, errorType: ErrorType(msg: "${e}"));
    }
  }

//
}
