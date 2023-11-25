import 'package:dio/dio.dart';
import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/data/DTO/user_request.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/model/user.dart';
import 'package:logger/logger.dart';

// MVVM패턴 : View -> Provider(전역프로바이더or뷰모델) -> Repository(통신+파싱을 책임)
// 나중에 싱글톤으로 바꿀것
class BoardRepository {
//

  // Future<ResponseDTO> fetchMain(String jwt) async {
  //   try {
  //     Response response = await dio.get("/users/main", options: Options(headers: {"Authorization": "${jwt}"}));
  //
  //     // 응답 받은 데이터 파싱
  //     ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);
  //
  //     print("${responseDTO}");
  //     MainPageDTO mainPageDTO = MainPageDTO.fromJson(responseDTO.data);
  //     print("mainPageDTO:${mainPageDTO}");
  //
  //     responseDTO.data = mainPageDTO;
  //
  //     return responseDTO;
  //   } catch (e) {
  //     if (e is DioError) {
  //       Logger().d("오류: ${e.response!.data}");
  //       return new ResponseDTO.fromJson(e.response!.data);
  //     }
  //
  //     // return ResponseDTO(-1, "게시글 한건 불러오기 실패", null);
  //     // return ResponseDTO(success: false, data: null, errorType: new ErrorType("13없음", 404));
  //     return ResponseDTO(success: false);
  //   }
  // }

//
}
