import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/data/dto/board_main_dto.dart';
import 'package:fishfront/data/dto/board_request_dto.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:logger/logger.dart';

// MVVM패턴 : View -> Provider(전역프로바이더or뷰모델) -> Repository(통신+파싱을 책임)
// 나중에 싱글톤으로 바꿀것
class BoardRepository {
//

  Future<ResponseDTO> fetchBoardMainList(String jwt) async {
    try {
      Response response = await dio.get("/boards", options: Options(headers: {"Authorization": "${jwt}"}));

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      // Logger().d(responseDTO);

      List<dynamic> mapList = responseDTO.data as List<dynamic>;
      // Logger().d(mapList);

      List<BoardMainDTO> boardMainDTOList = mapList.map((boardMain) => BoardMainDTO.fromJson(boardMain)).toList();
      // Logger().d(boardDTOList);

      responseDTO.data = boardMainDTOList;

      return responseDTO;
    } catch (e) {
      if (e is DioError) {
        Logger().d("오류: ${e.response!.data}");
        return new ResponseDTO.fromJson(e.response!.data);
      }

      // return ResponseDTO(-1, "게시글 한건 불러오기 실패", null);
      // return ResponseDTO(success: false, data: null, errorType: new ErrorType("13없음", 404));
      return ResponseDTO(success: false);
    }
  }

  Future<ResponseDTO> fetchBoard(String jwt, int boardId) async {
    try {
      Response response = await dio.get("/boards/${boardId}", options: Options(headers: {"Authorization": "${jwt}"}));

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      // Logger().d(responseDTO);

      responseDTO.data = BoardDTO.fromJson(responseDTO.data);

      return responseDTO;
    } catch (e) {
      if (e is DioError) {
        Logger().d("오류: ${e.response!.data}");
        return new ResponseDTO.fromJson(e.response!.data);
      }

      // return ResponseDTO(-1, "게시글 한건 불러오기 실패", null);
      // return ResponseDTO(success: false, data: null, errorType: new ErrorType("13없음", 404));
      return ResponseDTO(success: false);
    }
  }

  Future<ResponseDTO> fetchBoardCreate(String jwt, BoardRequestDTO boardRequestDTO, List<File>? imageFileList, File? videoFile) async {
    print("boardRequestDTO : ${boardRequestDTO}");

    try {
      Response? response;
      if (videoFile != null) {
        String fileName = videoFile.path.split('/').last;
        FormData formData = FormData.fromMap({
          "title": "${boardRequestDTO.title}",
          "text": "${boardRequestDTO.text ?? ""}",
          "aquariumId": "${boardRequestDTO.aquariumId}",
          "fishId": "${boardRequestDTO.fishId}",
          "videoFile": await MultipartFile.fromFile(videoFile.path, filename: fileName),
        });
        response = await dioFormData.post("/boards", data: formData, options: Options(headers: {"Authorization": "${jwt}"}));
      } else if (imageFileList != null && imageFileList.isNotEmpty) {
        FormData formData = FormData.fromMap({
          "title": "${boardRequestDTO.title}",
          "text": "${boardRequestDTO.text ?? ""}",
          "aquariumId": "${boardRequestDTO.aquariumId}",
          "fishId": "${boardRequestDTO.fishId}",
          'imageFileList': [
            for (File imageFile in imageFileList!) MultipartFile.fromFileSync(imageFile.path, filename: imageFile.path.split('/').last),
          ],
        });
        response = await dioFormData.post("/boards", data: formData, options: Options(headers: {"Authorization": "${jwt}"}));
      } else {
        FormData formData = FormData.fromMap({
          "title": "${boardRequestDTO.title}",
          "text": "${boardRequestDTO.text ?? ""}",
          "aquariumId": "${boardRequestDTO.aquariumId}",
          "fishId": "${boardRequestDTO.fishId}",
        });
        response = await dioFormData.post("/boards", data: formData, options: Options(headers: {"Authorization": "${jwt}"}));
      }

      print("response: ${response}");
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      responseDTO.data = new BoardDTO.fromJson(responseDTO.data);

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
