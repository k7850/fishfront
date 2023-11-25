import 'package:fishfront/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고 데이터
class RequestParam {
  int? bottomNavigationBarIndex;
  bool? isAutoLogin = false;
  bool? isLoginMove = false;
  int? aquariumDetailId;

  RequestParam();
}

// 2. 창고 (비지니스 로직)
class ParamStore extends RequestParam {
  final mContext = navigatorKey.currentContext;

  void addBottomNavigationBarIndex(int id) {
    print("파람addBottomNavigationBarIndex : ${id}");
    this.bottomNavigationBarIndex = id;
  }

  void addAquariumDetailId(int aquariumId) {
    print("파람프로바이더webtoonDetailId : ${aquariumId}");
    this.aquariumDetailId = aquariumId;
  }
}

// 3. 창고 관리자paramProvider
final paramProvider = Provider<ParamStore>((ref) {
  return new ParamStore();
});
