import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/data/DTO/user_request.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/model/user.dart';
import 'package:fishfront/data/repository/user_repository.dart';
import 'package:fishfront/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionUser {
  // 화면 context에 접근하는 법. 글로벌키
  final mContext = navigatorKey.currentContext;

  User? user;
  String? jwt;
  bool isLogin; // jwt가 있어도 시간 만료됐을수도 있으니까 필요함

  SessionUser({
    this.user,
    this.jwt,
    this.isLogin = false,
  });

  Future<void> join(JoinReqDTO joinReqDTO) async {
    // 1. 통신 코드
    ResponseDTO responseDTO = await UserRepository().fetchJoin(joinReqDTO);

    // 2. 비지니스 로직
    if (responseDTO.success == true) {
      Navigator.pushNamed(mContext!, "/login");
    } else {
      ScaffoldMessenger.of(mContext!).clearSnackBars();
      ScaffoldMessenger.of(mContext!).showSnackBar(SnackBar(content: Text(responseDTO.errorType!.msg!)));
    }
  }

  // Future<void> autoLogin(WidgetRef ref) async {
  //   print("자동로그인실행");
  //   String oldjwt = "";
  //   try {
  //     oldjwt = await secureStorage.read(key: 'jwt') as String;
  //   } catch (e) {
  //     print("자동로그인 secureStorage.read 실패");
  //   }
  //
  //   // 1. 통신 코드
  //   ResponseDTO responseDTO = await UserRepository().fetchAutoLogin(oldjwt);
  //
  //   // 2. 비지니스 로직
  //   if (responseDTO.success == true) {
  //     // 1. 세션값 갱신
  //     this.user = responseDTO.data as User;
  //     this.jwt = responseDTO.token;
  //     this.isLogin = true;
  //
  //     // 2. 디바이스에 JWT 저장 (자동 로그인)
  //     await secureStorage.write(key: "jwt", value: responseDTO.token);
  //
  //     // 3. 페이지 이동
  //     print("자동로그인성공");
  //     ref.read(paramProvider).isLoginMove = true;
  //     Navigator.pushNamedAndRemoveUntil(mContext!, Move.homeListPage, (route) => false);
  //   } else {
  //     print("자동로그인실패");
  //     Navigator.pushNamedAndRemoveUntil(mContext!, Move.loginPage, (route) => false);
  //   }
  // }

  Future<void> login(LoginReqDTO loginReqDTO) async {
    ResponseDTO responseDTO = await UserRepository().fetchLogin(loginReqDTO);

    if (responseDTO.success == true) {
      this.user = responseDTO.data as User;
      this.jwt = responseDTO.token;
      this.isLogin = true;

      await secureStorage.write(key: "jwt", value: responseDTO.token);
      print("로그인성공");

      Navigator.pushNamedAndRemoveUntil(mContext!, "/main", (route) => false);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(SnackBar(content: Text("${responseDTO.errorType!.msg!}")));
    }
  }

  // JWT는 로그아웃 할 때 서버로 요청할 필요가 없음.(어짜피 스테스리스로 서버에 정보가 없으니까)
  Future<void> logout() async {
    this.jwt = null;
    this.isLogin = false;
    this.user = null;

    await secureStorage.delete(key: "jwt");
    // await 없으면 삭제 전에 로그인페이지로 이동돼서 바로 다시 자동로그인 될 수 있음

    // Navigator.popAndPushNamed(context, Move.loginPage);
    Navigator.pushNamedAndRemoveUntil(mContext!, "/login", (route) => false);
    // 로그아웃이니까 스택 쌓인거 싹 다 없애기
  }
}

final sessionProvider = Provider<SessionUser>((ref) {
  return SessionUser();
});
