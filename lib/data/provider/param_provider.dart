import 'package:fishfront/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고 데이터
class RequestParam {
  int? bottomNavigationBarIndex;
  bool? isAutoLogin = false;
  bool? isLoginMove = false;
  int? aquariumDetailId;
  int? fishDetailId;

  RequestParam();
}

// 2. 창고 (비지니스 로직)
class ParamStore extends RequestParam {
  final mContext = navigatorKey.currentContext;

  void addBottomNavigationBarIndex(int bottomNavigationBarIndex) {
    print("bottomNavigationBarIndex : ${bottomNavigationBarIndex}");
    this.bottomNavigationBarIndex = bottomNavigationBarIndex;
  }

  void addAquariumDetailId(int aquariumId) {
    print("aquariumId : ${aquariumId}");
    this.aquariumDetailId = aquariumId;
  }

  void addFishDetailId(int fishDetailId) {
    print("fishDetailId : ${fishDetailId}");
    this.fishDetailId = fishDetailId;
  }
}

// 3. 창고 관리자paramProvider
final paramProvider = Provider<ParamStore>((ref) {
  return new ParamStore();
});
