class ResponseDTO {
  String? token; // 헤더로 던진 토큰 값을 담아두는 변수
  dynamic? data; // 서버에서 응답한 데이터를 담아두는 변수
  bool success;
  ErrorType? errorType;

  ResponseDTO({
    this.data,
    required this.success,
    this.errorType,
  });

  ResponseDTO.fromJson(Map<String, dynamic> json)
      : data = json["data"],
        success = json["success"],
        errorType = json["errorType"] == null ? json["errorType"] : ErrorType.fromJson(json["errorType"]);

  @override
  String toString() {
    return 'ResponseDTO{token: $token, data: $data, success: $success, errorType: $errorType}';
  }

// response에만 쓰니까 toJson은 필요없다
}

class ErrorType {
  String? msg;
  int? code;

  ErrorType({this.msg, this.code});

  ErrorType.fromJson(Map<String, dynamic> json)
      : msg = json["msg"],
        code = json["code"];

  @override
  String toString() {
    return 'ErrorType{msg: $msg, code: $code}';
  }
}
