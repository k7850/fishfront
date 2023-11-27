import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ↓↓↓↓ 통신용 백엔드 서버 주소 여기
const String serverURL = "http://172.30.1.18:8081"; // 집

const String imageURL = "${serverURL}/image?route=";

// http 통신
final dio = Dio(
  BaseOptions(
    baseUrl: serverURL,
    contentType: "application/json; charset=utf-8",
  ),
);

final dioFormData = Dio(
  BaseOptions(
    baseUrl: serverURL,
    contentType: "multipart/form-data; charset=utf-8",
  ),
);

// 휴대폰 로컬에 파일로 저장
const secureStorage = FlutterSecureStorage();
