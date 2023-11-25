import 'package:dio/dio.dart';
import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/data/DTO/user_request.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
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
        Logger().d("오류: ${e.response!.data}");
        return new ResponseDTO.fromJson(e.response!.data);
      }

      // return ResponseDTO(success: false, data: null, errorType: new ErrorType(message: "${e}", status: 404));
      return ResponseDTO(success: false);
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

//
}
