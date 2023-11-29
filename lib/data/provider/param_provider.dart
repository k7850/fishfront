import 'package:fishfront/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestParam {
  int? bottomNavigationBarIndex;
  bool? isAutoLogin = false;
  bool? isLoginMove = false;
  int? aquariumDetailId;
  int? fishDetailId;
  int? bookDetailId;

  RequestParam();
}

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

  void addBookDetailId(int bookDetailId) {
    print("fishDetailId : ${bookDetailId}");
    this.bookDetailId = bookDetailId;
  }
}

final paramProvider = Provider<ParamStore>((ref) {
  return new ParamStore();
});
