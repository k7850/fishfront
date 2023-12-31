import 'package:dio/dio.dart';
import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/data/DTO/user_request.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/model/user.dart';

// MVVM패턴 : View -> Provider(전역프로바이더or뷰모델) -> Repository(통신+파싱을 책임)
// 나중에 싱글톤으로 바꿀것
class UserRepository {
//

  Future<ResponseDTO> fetchJoin(JoinReqDTO requestDTO) async {
    try {
      // requestDTO.tokenFCM = myTokenFCM;
      Response response = await dio.post("/join", data: requestDTO.toJson()); // await dio.http메서드타입("주소", data: 보낼객체.toJson());
      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      // Map타입을 유저타입으로 바꿔주기 (그래도 타입은 dynamic이니까 사용할때 as User 붙여서)
      // 필요할때만 쓰면 됨
      // responseDTO.data = User.fromJson(responseDTO.data);

      return responseDTO;
    } catch (e) {
      return new ResponseDTO(success: false, errorType: ErrorType(msg: "가입실패"));
    }
  }

//

  Future<ResponseDTO> fetchAutoLogin(String oldjwt) async {
    try {
      Response response = await dio.post("/autologin", options: Options(headers: {"Authorization": "${oldjwt}"}));

      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      responseDTO.data = new User.fromJson(responseDTO.data);

      List<String>? jwt = response.headers["Authorization"];

      if (jwt != null) {
        responseDTO.token = jwt.first; // jwt[0]과 같음
      }

      // 필요할때만 쓰기
      // responseDTO.data = User.fromJson(responseDTO.data);

      return responseDTO;
    } catch (e) {
      // 200이 아니면 catch로 감
      return new ResponseDTO(success: false, errorType: ErrorType(msg: "자동 로그인 실패"));
    }
  }

//

  Future<ResponseDTO> fetchLogin(LoginReqDTO requestDTO) async {
    try {
      Response response = await dio.post("/login", data: requestDTO.toJson());

      ResponseDTO responseDTO = new ResponseDTO.fromJson(response.data);

      responseDTO.data = new User.fromJson(responseDTO.data);

      List<String>? jwt = response.headers["Authorization"];

      if (jwt != null) {
        responseDTO.token = jwt.first; // jwt[0]과 같음
      }

      // 필요할때만 쓰기
      // responseDTO.data = User.fromJson(responseDTO.data);

      return responseDTO;
    } catch (e) {
      // 200이 아니면 catch로 감
      return new ResponseDTO(success: false, errorType: ErrorType(msg: "로그인 실패"));
    }
  }
//
}
