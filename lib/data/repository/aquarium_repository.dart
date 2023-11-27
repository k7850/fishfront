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
import 'package:fishfront/data/model/user.dart';
import 'package:logger/logger.dart';

// MVVM패턴 : View -> Provider(전역프로바이더or뷰모델) -> Repository(통신+파싱을 책임)
// 나중에 싱글톤으로 바꿀것
class AquariumRepository {
//

  Future<ResponseDTO> fetchAquarium(String jwt) async {
    try {
      Response response = await dio.get("/aquariums", options: Options(headers: {"Authorization": "${jwt}"}));

      // 응답 받은 데이터 파싱
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      List<dynamic> mapList = responseDTO.data as List<dynamic>;

      List<AquariumDTO> aquariumDTOList = mapList.map((aquariumDTO) => AquariumDTO.fromJson(aquariumDTO)).toList();

      responseDTO.data = aquariumDTOList;

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

  Future<ResponseDTO> fetchScheduleCheck(String jwt, int scheduleId, bool scheduleIsCompleted) async {
    try {
      Response response;

      if (scheduleIsCompleted == true) {
        response = await dio.post("/schedules/checkcancel/${scheduleId}", options: Options(headers: {"Authorization": "${jwt}"}));
      } else {
        response = await dio.post("/schedules/check/${scheduleId}", options: Options(headers: {"Authorization": "${jwt}"}));
      }

      // print("response.data: ${response.data}");
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      responseDTO.data = new ScheduleDTO.fromJson(responseDTO.data);

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

  Future<ResponseDTO> fetchScheduleDelete(String jwt, int scheduleId) async {
    try {
      Response response = await dio.delete("/schedules/${scheduleId}", options: Options(headers: {"Authorization": "${jwt}"}));

      // print("response.data: ${response.data}");
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      responseDTO.data = new ScheduleDTO.fromJson(responseDTO.data);

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

  Future<ResponseDTO> fetchScheduleCreate(String jwt, int aquariumId, ScheduleRequestDTO scheduleRequestDTO) async {
    print("scheduleRequestDTO : ${scheduleRequestDTO}");
    print("scheduleRequestDTO.toJson() : ${scheduleRequestDTO.toJson()}");
    try {
      Response response =
          await dio.post("/schedules/${aquariumId}", data: scheduleRequestDTO.toJson(), options: Options(headers: {"Authorization": "${jwt}"}));

      print("response: ${response}");
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      responseDTO.data = new ScheduleDTO.fromJson(responseDTO.data);

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

  Future<ResponseDTO> fetchFishDelete(String jwt, int fishId) async {
    try {
      Response response = await dio.delete("/fishes/${fishId}", options: Options(headers: {"Authorization": "${jwt}"}));

      // print("response.data: ${response.data}");
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      responseDTO.data = new FishDTO.fromJson(responseDTO.data);

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

  Future<ResponseDTO> fetchFishCreate(String jwt, int aquariumId, FishRequestDTO fishRequestDTO, File? imageFile) async {
    // print("fishRequestDTO : ${fishRequestDTO}");
    // print("fishRequestDTO.toJson() : ${fishRequestDTO.toJson()}");
    try {
      Response response;
      if (imageFile == null) {
        FormData formData = FormData.fromMap({
          "fishClassEnum": "${fishRequestDTO.fishClassEnum}",
          "name": "${fishRequestDTO.name ?? ""}",
          "text": "${fishRequestDTO.text ?? ""}",
          "quantity": "${fishRequestDTO.quantity ?? ""}",
          "isMale": "${fishRequestDTO.isMale ?? ""}",
          "photo": "${fishRequestDTO.photo ?? ""}",
          "price": "${fishRequestDTO.price ?? ""}",
          fishRequestDTO.bookId == null ? "" : "bookId": "${fishRequestDTO.bookId}",
        });
        response = await dioFormData.post("/fishes/${aquariumId}", data: formData, options: Options(headers: {"Authorization": "${jwt}"}));
      } else {
        String fileName = imageFile.path.split('/').last;
        FormData formData = FormData.fromMap({
          "fishClassEnum": "${fishRequestDTO.fishClassEnum}",
          "name": "${fishRequestDTO.name ?? ""}",
          "text": "${fishRequestDTO.text ?? ""}",
          "quantity": "${fishRequestDTO.quantity ?? ""}",
          "isMale": "${fishRequestDTO.isMale ?? ""}",
          "photo": "${fishRequestDTO.photo ?? ""}",
          "price": "${fishRequestDTO.price ?? ""}",
          fishRequestDTO.bookId == null ? "" : "bookId": "${fishRequestDTO.bookId}",
          "photoFile": await MultipartFile.fromFile(imageFile.path, filename: fileName),
        });

        response = await dioFormData.post("/fishes/${aquariumId}", data: formData, options: Options(headers: {"Authorization": "${jwt}"}));
      }
      ;

      print("response: ${response}");
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      responseDTO.data = new FishDTO.fromJson(responseDTO.data);

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

  Future<ResponseDTO> fetchFishMove(String jwt, int fishId, int aquariumId) async {
    try {
      Response response = await dio.patch("/fishes/${fishId}/${aquariumId}", options: Options(headers: {"Authorization": "${jwt}"}));

      print("response: ${response}");
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      responseDTO.data = new FishDTO.fromJson(responseDTO.data);

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

  Future<ResponseDTO> fetchFishUpdate(String jwt, int aquariumId, int fishId, FishRequestDTO fishRequestDTO, File? imageFile) async {
    // print("fishRequestDTO : ${fishRequestDTO}");
    // print("fishRequestDTO.toJson() : ${fishRequestDTO.toJson()}");

    try {
      Response response;
      if (imageFile == null) {
        FormData formData = FormData.fromMap({
          "fishClassEnum": "${fishRequestDTO.fishClassEnum}",
          "name": "${fishRequestDTO.name ?? ""}",
          "text": "${fishRequestDTO.text ?? ""}",
          "quantity": "${fishRequestDTO.quantity ?? ""}",
          "isMale": "${fishRequestDTO.isMale ?? ""}",
          "photo": "${fishRequestDTO.photo ?? ""}",
          "price": "${fishRequestDTO.price ?? ""}",
          fishRequestDTO.bookId == null ? "" : "bookId": "${fishRequestDTO.bookId}",
        });

        response = await dioFormData.put("/fishes/${fishId}/${aquariumId}", data: formData, options: Options(headers: {"Authorization": "${jwt}"}));
      } else {
        String fileName = imageFile.path.split('/').last;
        FormData formData = FormData.fromMap({
          "fishClassEnum": "${fishRequestDTO.fishClassEnum}",
          "name": "${fishRequestDTO.name ?? ""}",
          "text": "${fishRequestDTO.text ?? ""}",
          "quantity": "${fishRequestDTO.quantity ?? ""}",
          "isMale": "${fishRequestDTO.isMale ?? ""}",
          "photo": "${fishRequestDTO.photo ?? ""}",
          "price": "${fishRequestDTO.price ?? ""}",
          fishRequestDTO.bookId == null ? "" : "bookId": "${fishRequestDTO.bookId}",
          "photoFile": await MultipartFile.fromFile(imageFile.path, filename: fileName),
        });

        response = await dioFormData.put("/fishes/${fishId}/${aquariumId}", data: formData, options: Options(headers: {"Authorization": "${jwt}"}));
      }

      print("response: ${response}");
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);
      responseDTO.data = new FishDTO.fromJson(responseDTO.data);

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
