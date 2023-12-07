import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/format_day.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/event.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DetailScheduleModel {
  TextEditingController eventController;

  DateTime day0101;
  DateTime selectedDay;
  int durationDay;

  bool toggleFood;
  bool toggleWaterChange;
  bool toggleImportant;

  Map<DateTime, List<Event>> eventMap;

  List<Event> selectedEventList;

  AquariumDTO aquariumDTO;

  List<ScheduleDTO> scheduleDTOList;

  DetailScheduleModel.copy(DetailScheduleModel copyState)
      : eventController = copyState.eventController,
        day0101 = copyState.day0101,
        selectedDay = copyState.selectedDay,
        durationDay = copyState.durationDay,
        toggleFood = copyState.toggleFood,
        toggleWaterChange = copyState.toggleWaterChange,
        toggleImportant = copyState.toggleImportant,
        eventMap = copyState.eventMap,
        selectedEventList = copyState.selectedEventList,
        aquariumDTO = copyState.aquariumDTO,
        scheduleDTOList = copyState.scheduleDTOList;

  DetailScheduleModel({
    required this.eventController,
    required this.day0101,
    required this.selectedDay,
    required this.durationDay,
    required this.aquariumDTO,
    required this.toggleFood,
    required this.toggleWaterChange,
    required this.toggleImportant,
    required this.eventMap,
    required this.selectedEventList,
    required this.scheduleDTOList,
  });
}

class DetailScheduleViewModel extends StateNotifier<DetailScheduleModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  DetailScheduleViewModel(this.ref, super._state);

  Future<void> notifyInit() async {
    print("스케줄노티파이어인잇");
    ParamStore paramStore = ref.read(paramProvider);

    TextEditingController eventController = TextEditingController();

    // DateTime day0101 = DateTime.utc(DateTime.now().year - 1, 01, 01);
    DateTime day0101 = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime selectedDay = DateTime.now();
    int durationDay = 1095; // 3년

    bool toggleFood = false;
    bool toggleWaterChange = false;
    bool toggleImportant = false;

    Map<DateTime, List<Event>> eventMap = {};

    AquariumDTO aquariumDTO = ref
        .read(mainProvider)!
        .aquariumDTOList //
        .firstWhere((element) => element.id == paramStore.aquariumDetailId);

    List<ScheduleDTO> scheduleDTOList = aquariumDTO.scheduleDTOList;

    void calendarViewIf(ScheduleDTO scheduleDTO, int day) {
      // DateTime startDay = DateTime.utc(DateTime.now().year, DateTime.now().month, 1);
      // DateTime startDay = scheduleDTO.targetDay!;

      DateTime startDay = formatDay(scheduleDTO.targetDay!);

      // print("1: ${DateTime.utc(DateTime.now().year, DateTime.now().month, 1)}");
      // print("2: ${scheduleDTO.targetDay!}");
      // print("3: ${startDay}");

      for (int i = 0; i < durationDay; i += day) {
        if (startDay.add(Duration(days: i)).isBefore(day0101)) continue;
        eventMap[startDay.add(Duration(days: i))] ??= [];
        eventMap[startDay.add(Duration(days: i))]!.add(
          Event(title: scheduleDTO.title, isCompleted: scheduleDTO.isCompleted, scheduleId: scheduleDTO.id, importantly: scheduleDTO.importantly),
        );
      }
    }

    for (ScheduleDTO scheduleDTO in scheduleDTOList) {
      if (scheduleDTO.scheduleEnum == "지정") {
        DateTime parsedDate = formatDay(scheduleDTO.targetDay!);
        eventMap[parsedDate] ??= [];
        eventMap[parsedDate]!.add(
          Event(title: scheduleDTO.title, isCompleted: scheduleDTO.isCompleted, scheduleId: scheduleDTO.id, importantly: scheduleDTO.importantly),
        );
      }

      if (scheduleDTO.scheduleEnum == "요일") {
        DateTime targetWeek = day0101;
        while (targetWeek.weekday != scheduleDTO.betweenDay) {
          targetWeek = targetWeek.add(Duration(days: 1));
        }
        for (int i = 0; i < durationDay; i += 7) {
          eventMap[targetWeek.add(Duration(days: i))] ??= [];
          eventMap[targetWeek.add(Duration(days: i))]!.add(
            Event(title: scheduleDTO.title, isCompleted: scheduleDTO.isCompleted, scheduleId: scheduleDTO.id, importantly: scheduleDTO.importantly),
          );
        }
      }

      if (scheduleDTO.scheduleEnum == "간격") {
        if (scheduleDTO.betweenDay == 1) calendarViewIf(scheduleDTO, 1);
        if (scheduleDTO.betweenDay == 2) calendarViewIf(scheduleDTO, 2);
        if (scheduleDTO.betweenDay == 4) calendarViewIf(scheduleDTO, 4);
        if (scheduleDTO.betweenDay == 10) calendarViewIf(scheduleDTO, 10);
        if (scheduleDTO.betweenDay == 30) calendarViewIf(scheduleDTO, 30);
      }
    }

    for (var diary in aquariumDTO.diaryDTOList) {
      // print("diary.createdAt : ${diary.createdAt}");
      // String formattedDate = DateFormat('yyyy-MM-dd').format(diary.createdAt);
      // DateTime parsedDate = DateFormat('yyyy-MM-dd').parseUTC(formattedDate);

      DateTime target = formatDay(diary.createdAt);

      eventMap[target] ??= [];
      eventMap[target]!.add(
        Event(title: diary.title == null || diary.title!.isEmpty ? "기록" : "${diary.title}", diaryId: diary.id),
      );
      // print(eventMap[parsedDate]);
    }

    //

    // String formattedDate = DateFormat('yyyy-MM-dd 00:00:00.000Z').format(selectedDay);
    // DateTime parsedDate = DateFormat('yyyy-MM-dd 00:00:00.000Z').parseUTC(formattedDate);

    DateTime target = formatDay(selectedDay);

    List<Event> selectedEventList = eventMap[target] ?? [];

    state = await DetailScheduleModel(
      eventController: eventController,
      day0101: day0101,
      selectedDay: selectedDay,
      durationDay: durationDay,
      aquariumDTO: aquariumDTO,
      toggleFood: toggleFood,
      toggleWaterChange: toggleWaterChange,
      toggleImportant: toggleImportant,
      eventMap: eventMap,
      selectedEventList: selectedEventList,
      scheduleDTOList: scheduleDTOList,
    );
  }

  Future<void> notifyEventMap(Map<DateTime, List<Event>> eventMap) async {
    print("notifyEventMap : ${eventMap}");

    DetailScheduleModel copyState = state!;
    copyState.eventMap = eventMap;
    state = DetailScheduleModel.copy(copyState);
  }

  Future<void> notifySelectedEventList(List<Event> selectedEventList) async {
    print("notifySelectedEventList : ${selectedEventList}");

    DetailScheduleModel copyState = state!;
    copyState.selectedEventList = selectedEventList;
    state = DetailScheduleModel.copy(copyState);
  }

  Future<void> notifySelectedDay(DateTime selectedDay) async {
    print("notifySelectedDay : ${selectedDay}");

    DetailScheduleModel copyState = state!;
    copyState.selectedDay = selectedDay;
    state = DetailScheduleModel.copy(copyState);
  }

  Future<void> notifyToggleFood() async {
    print("notifyToggleFood ");

    DetailScheduleModel copyState = state!;
    copyState.toggleFood = !state!.toggleFood;
    state = DetailScheduleModel.copy(copyState);
  }

  Future<void> notifyToggleWaterChange() async {
    print("notifyToggleWaterChange ");

    DetailScheduleModel copyState = state!;
    copyState.toggleWaterChange = !state!.toggleWaterChange;
    state = DetailScheduleModel.copy(copyState);
  }

  Future<void> notifyToggleImportant() async {
    print("notifyToggleImportant ");

    DetailScheduleModel copyState = state!;
    copyState.toggleImportant = !state!.toggleImportant;
    state = DetailScheduleModel.copy(copyState);
  }

//
}

final detailScheduleProvider = StateNotifierProvider.autoDispose<DetailScheduleViewModel, DetailScheduleModel?>((ref) {
  // return new DetailOtherViewModel(ref, null)..notifyInit();
  return new DetailScheduleViewModel(ref, null);
});
