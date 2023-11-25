import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/response_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/dto/schedule_request_dto.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/data/repository/aquarium_repository.dart';
import 'package:fishfront/data/repository/board_repository.dart';
import 'package:fishfront/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class MainModel {
  List<AquariumDTO> aquariumDTOList;

  MainModel({required this.aquariumDTOList});

  // MainModel interestCountUpdate({required int updateInterestCount, required bool nowIsInterest}) {
  //   DetailPageWebtoonDTO updateWebtoonDTO = this.webtoonDTO!;
  //   updateWebtoonDTO.interestCount = updateInterestCount;
  //   updateWebtoonDTO.isInterest = nowIsInterest;
  //   if (nowIsInterest == true) {
  //     updateWebtoonDTO.isAlarm = true;
  //   }
  //   if (nowIsInterest == false) {
  //     updateWebtoonDTO.isAlarm = true;
  //   }
  //   return MainModel(webtoonDTO: updateWebtoonDTO);
  // }

  // MainModel interestAlarmUpdate({required bool isAlarm}) {
  //   DetailPageWebtoonDTO updateWebtoonDTO = this.webtoonDTO!;
  //   updateWebtoonDTO.isAlarm = isAlarm;
  //   return MainModel(webtoonDTO: updateWebtoonDTO);
  // }
}

// 2. 창고
class MainViewModel extends StateNotifier<MainModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  MainViewModel(this.ref, super._state);

  // notify 구독자들에게 알려줌
  Future<void> notifyInit() async {
    print("메인아쿠아리움노티파이어인잇");
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchAquarium(sessionUser.jwt!);

    state = MainModel(aquariumDTOList: responseDTO.data);
    print(state!.aquariumDTOList[0].scheduleDTOList[2].targetDay);
    print(state!.aquariumDTOList[0].scheduleDTOList[2].targetDay.runtimeType);
  }

  Future<void> notifyScheduleCheck(int scheduleId, bool scheduleIsCompleted) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchScheduleCheck(sessionUser.jwt!, scheduleId, scheduleIsCompleted);

    if (responseDTO.success == false) {
      print("스케줄체크실패 : ${responseDTO}");
      notifyInit();
      return;
    }

    ScheduleDTO scheduleDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    aquariumDTOList
        .firstWhere((e) => e.id == scheduleDTO.aquariumId) //
        .scheduleDTOList //
        .firstWhere((e) => e.id == scheduleDTO.id) //
        .isCompleted = scheduleDTO.isCompleted;

    state = MainModel(aquariumDTOList: aquariumDTOList);
  }

  Future<void> notifyScheduleDelete(int scheduleId) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchScheduleDelete(sessionUser.jwt!, scheduleId);

    if (responseDTO.success == false) {
      print("삭제실패 : ${responseDTO}");
      notifyInit();
      return;
    }

    ScheduleDTO scheduleDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    aquariumDTOList
        .firstWhere((e) => e.id == scheduleDTO.aquariumId) //
        .scheduleDTOList //
        .removeWhere((e) => e.id == scheduleDTO.id);

    state = MainModel(aquariumDTOList: aquariumDTOList);
  }

  Future<void> notifyScheduleCreate(int aquariumId, ScheduleRequestDTO scheduleRequestDTO) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await AquariumRepository().fetchScheduleCreate(sessionUser.jwt!, aquariumId, scheduleRequestDTO);

    if (responseDTO.success == false) {
      print("생성실패 : ${responseDTO}");
      notifyInit();
      return;
    }

    ScheduleDTO scheduleDTO = responseDTO.data;

    List<AquariumDTO> aquariumDTOList = state!.aquariumDTOList;

    aquariumDTOList
        .firstWhere((e) => e.id == scheduleDTO.aquariumId) //
        .scheduleDTOList //
        .add(scheduleDTO);

    state = MainModel(aquariumDTOList: aquariumDTOList);
  }

// Future<void> notifyEpisodeViewUpdate(int epId) async {
  //   if (state == null) {
  //     print("웹툰 디테일 거쳐서 접근하지 않음");
  //     // 어짜피 디테일 거쳐서 안왔으면 디테일로 접근할때 새로고침되니까 반영됨
  //     return;
  //   }
  //   DetailPageWebtoonDTO detailDTO = state!.webtoonDTO!;
  //
  //   detailDTO.episodeList.map((e) => e.isLastView = false).toList();
  //
  //   DetailPageEpisodeDTO ep = detailDTO.episodeList.firstWhere((element) => element.episodeId == epId);
  //   ep.isLastView = true;
  //   ep.isView = true;
  //
  //   state = WebtoonDetailModel(webtoonDTO: detailDTO);
  //   print("에피소드 본거 디테일에 반영됨");
  // }

  // Future<void> notifyInterestAlarmOn() async {
  //   SessionUser sessionUser = ref.read(sessionProvider);
  //
  //   int webtoonId = state!.webtoonDTO!.id;
  //   ResponseDTO responseDTO = await WebtoonRepository().fetchInterestAlarmOn(sessionUser.jwt!, webtoonId);
  //
  //   if (responseDTO.success == false) {
  //     print("if로감On");
  //     return;
  //   }
  //
  //   state = state!.interestAlarmUpdate(isAlarm: (responseDTO.data as InterestWebtoonDTO).isAlarm);
  // }

  // Future<void> notifyInterestAlarmOff() async {
  //   SessionUser sessionUser = ref.read(sessionProvider);
  //
  //   int webtoonId = state!.webtoonDTO!.id;
  //   ResponseDTO responseDTO = await WebtoonRepository().fetchInterestAlarmOff(sessionUser.jwt!, webtoonId);
  //
  //   if (responseDTO.success == false) {
  //     print("if로감Off");
  //     return;
  //   }
  //
  //   state = state!.interestAlarmUpdate(isAlarm: (responseDTO.data as InterestWebtoonDTO).isAlarm);
  // }

  // Future<void> notifyInterestCreate() async {
  //   SessionUser sessionUser = ref.read(sessionProvider);
  //
  //   int webtoonId = state!.webtoonDTO!.id;
  //   ResponseDTO responseDTO = await WebtoonRepository().fetchInterestCreate(sessionUser.jwt!, webtoonId);
  //
  //   if (responseDTO.success == false) {
  //     // notifyInterestDelete();
  //     return;
  //   }
  //   state = state!.interestCountUpdate(
  //     updateInterestCount: (responseDTO.data as InterestDTO).webtoonTotalInterest,
  //     nowIsInterest: true,
  //   );
  //   // state!.webtoonDTO!.interestCount = (responseDTO.data as InterestDTO).webtoonTotalInterest; // TODO 이거론 왜 안되지
  // }

  // Future<void> notifyInterestDelete() async {
  //   SessionUser sessionUser = ref.read(sessionProvider);
  //
  //   int webtoonId = state!.webtoonDTO!.id;
  //   ResponseDTO responseDTO = await WebtoonRepository().fetchInterestDelete(sessionUser.jwt!, webtoonId);
  //
  //   if (responseDTO.success == false) {
  //     // notifyInterestCreate();
  //     return;
  //   }
  //   state = state!.interestCountUpdate(
  //     updateInterestCount: (responseDTO.data as InterestDTO).webtoonTotalInterest,
  //     nowIsInterest: false,
  //   );
  //   // state!.webtoonDTO!.interestCount = (responseDTO.data as InterestDTO).webtoonTotalInterest; // TODO 이거론 왜 안되지
  // }

  // Future<void> notifyRandom() async {
  //   SessionUser sessionUser = ref.read(sessionProvider);
  //   ResponseDTO responseDTO = await WebtoonRepository().fetchRandom(sessionUser.jwt!);
  //
  //   ParamStore paramStore = ref.read(paramProvider);
  //   paramStore.webtoonDetailId = responseDTO.data.id;
  // }

//
}

// 3. 창고 관리자 (View가 빌드되기 직전에 생성됨)
final mainProvider = StateNotifierProvider.autoDispose<MainViewModel, MainModel?>((ref) {
  // Logger().d("Main 뷰모델");
  // return new MainViewModel(ref, null)..notifyInit();
  return new MainViewModel(ref, null);
});
