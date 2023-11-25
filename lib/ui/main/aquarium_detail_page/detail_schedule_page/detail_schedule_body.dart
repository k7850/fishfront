import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/dto/schedule_request_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/main/aquarium_detail_page/aquarium_detail_page.dart';
import 'package:fishfront/ui/main/aquarium_detail_page/detail_schedule_page/widgets/event.dart';
import 'package:fishfront/ui/main/main_page/main_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailScheduleBody extends ConsumerStatefulWidget {
  @override
  _DetailScheduleBodyState createState() => _DetailScheduleBodyState();
}

class _DetailScheduleBodyState extends ConsumerState<DetailScheduleBody> {
  DateTime day0101 = DateTime.utc(DateTime.now().year - 1, 01, 01);
  DateTime selectedDay = DateTime.now();

  int durationDay = 1095; // 3년

  late MainModel model;
  late AquariumDTO aquariumDTO;

  late bool toggleFood;
  late bool toggleWaterChange;
  late bool toggleImportant;

  Map<DateTime, List<Event>> events = {};

  TextEditingController _eventController = new TextEditingController();

  late final ValueNotifier<List<Event>> _selectedEvents;

  late List<ScheduleDTO> scheduleDTOList = aquariumDTO.scheduleDTOList;

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    super.didChangeDependencies();

    MainModel? model = ref.watch(mainProvider);
    if (model == null) {
      ref.read(mainProvider.notifier).notifyInit();
      // return Center(child: CircularProgressIndicator());
    }

    ParamStore paramStore = ref.read(paramProvider);

    aquariumDTO = model!.aquariumDTOList //
        .firstWhere((element) => element.id == paramStore.aquariumDetailId);

    toggleFood = false;
    toggleWaterChange = false;
    toggleImportant = false;

    scheduleDTOList.forEach((scheduleDTO) {
      if (scheduleDTO.scheduleEnum == "지정") {
        String formattedDate = DateFormat('yyyy-MM-dd 00:00:00.000Z').format(scheduleDTO.targetDay!);
        DateTime parsedDate = DateFormat('yyyy-MM-dd 00:00:00.000Z').parseUTC(formattedDate);
        events[parsedDate] ??= [];
        events[parsedDate]!.add(Event("${scheduleDTO.title}", isCompleted: scheduleDTO.isCompleted, scheduleId: scheduleDTO.id));
      } else if (scheduleDTO.scheduleEnum == "요일") {
        DateTime targetWeek = day0101;
        while (targetWeek.weekday != scheduleDTO.betweenDay) {
          targetWeek = targetWeek.add(Duration(days: 1));
        }
        for (int i = 0; i < durationDay; i += 7) {
          events[targetWeek.add(Duration(days: i))] ??= [];
          events[targetWeek.add(Duration(days: i))]!
              .add(Event("${scheduleDTO.title}", isCompleted: scheduleDTO.isCompleted, scheduleId: scheduleDTO.id));
        }
      } else {
        if (scheduleDTO.betweenDay == 1) {
          for (int i = 0; i < durationDay; i += 1) {
            events[day0101.add(Duration(days: i))] ??= [];
            events[day0101.add(Duration(days: i))]!
                .add(Event("${scheduleDTO.title}", isCompleted: scheduleDTO.isCompleted, scheduleId: scheduleDTO.id));
          }
        }
        if (scheduleDTO.betweenDay == 10) {
          for (int i = 0; i < durationDay; i += 10) {
            events[day0101.add(Duration(days: i))] ??= [];
            events[day0101.add(Duration(days: i))]!
                .add(Event("${scheduleDTO.title}", isCompleted: scheduleDTO.isCompleted, scheduleId: scheduleDTO.id));
          }
        }
      }

      // print("events4:${events}");
    });

    // for (int i = 0; i < durationDay; i += 1) {
    //   events[day0101.add(Duration(days: i))] ??= [];
    //   events[day0101.add(Duration(days: i))]!.add(Event("사료 급여"));
    // }
    // print("events5:${events}");
    //
    // for (int i = 0; i < durationDay; i += 7) {
    //   events[day0101.add(Duration(days: i))] ??= [];
    //   events[day0101.add(Duration(days: i))]!.add(Event("물 환수"));
    // }

    String formattedDate = DateFormat('yyyy-MM-dd 00:00:00.000Z').format(selectedDay);
    DateTime parsedDate = DateFormat('yyyy-MM-dd 00:00:00.000Z').parseUTC(formattedDate);

    _selectedEvents = ValueNotifier(_getEventsForDay(parsedDate));
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    print("빌드됨");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(color: Colors.blue.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  TableCalendar(
                    locale: 'ko_KR',
                    firstDay: day0101,
                    lastDay: day0101.add(Duration(days: durationDay)),
                    focusedDay: selectedDay,
                    rowHeight: 45,
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      titleTextFormatter: (date, locale) => DateFormat.yMMMMd(locale).format(selectedDay),
                      formatButtonVisible: false,
                      titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
                      headerPadding: EdgeInsets.only(bottom: 5),
                      // leftChevronIcon: const Icon(Icons.arrow_left, size: 40.0),
                      // rightChevronIcon: const Icon(Icons.arrow_right, size: 40.0),
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, events) {
                        if (events.isEmpty) return SizedBox();
                        // print("events: ${events}");
                        // print(events.runtimeType);

                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              // print("events: ${events}");
                              return Container(
                                margin: const EdgeInsets.only(top: 25),
                                padding: const EdgeInsets.all(1),
                                child: events[index].toString().contains("사료 급여") && toggleFood
                                    ? SizedBox()
                                    : events[index].toString().contains("물 환수") && toggleWaterChange
                                        ? SizedBox()
                                        : Container(
                                            width: 8,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: events[index].toString().contains("사료 급여")
                                                  ? Colors.black38
                                                  : events[index].toString().contains("물 환수")
                                                      ? Colors.green[600]
                                                      : Colors.red[300],
                                            ),
                                          ),
                              );
                            });
                      },
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(color: Colors.yellow[200], shape: BoxShape.circle),
                      todayTextStyle: TextStyle(fontSize: 20),
                      selectedDecoration: BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
                      selectedTextStyle: TextStyle(fontSize: 20),
                      // markerDecoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    ),
                    onDaySelected: (selected, focusedDay) {
                      this.selectedDay = selected;
                      _selectedEvents.value = _getEventsForDay(selectedDay);
                      setState(() {});
                    },
                    selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                    eventLoader: _getEventsForDay,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(color: Colors.grey, height: 1, thickness: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          // print(toggleFood);
                          toggleFood = !toggleFood;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Text("${toggleFood ? "사료 급여 보이기" : "사료 급여 숨기기"} ", style: TextStyle(color: Colors.black)),
                            Container(height: 8, width: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black38)),
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          // print(toggleWaterChange);
                          toggleWaterChange = !toggleWaterChange;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Text("${toggleWaterChange ? "물 환수 보이기" : "물 환수 숨기기"} ", style: TextStyle(color: Colors.black)),
                            Container(height: 8, width: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              constraints: BoxConstraints(minHeight: 42),
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
              // height: MediaQuery.of(context).size.height,
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return value.length == 0
                      ? Container(child: Text(" 일정이 없거나, 날짜를 선택하지 않음."), margin: EdgeInsets.symmetric(vertical: 6))
                      : Column(
                          children: value.map((event) {
                            return DateTime.now().day == selectedDay.day &&
                                    DateTime.now().month == selectedDay.month &&
                                    DateTime.now().year == selectedDay.year
                                ? InkWell(
                                    onTap: () {
                                      scheduleDTOList.forEach((schedule) async {
                                        if (schedule.id == event.scheduleId) {
                                          await ref.watch(mainProvider.notifier).notifyScheduleCheck(schedule.id, schedule.isCompleted);

                                          event.isCompleted = !event.isCompleted;
                                          // schedule.isCompleted = !schedule.isCompleted;
                                        }
                                      });
                                      setState(() {});
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                      child: Row(
                                        children: [
                                          event.isCompleted ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
                                          SizedBox(width: 5),
                                          Container(
                                            constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.6),
                                            // width: sizeGetScreenWidth(context) * 0.6,
                                            child: Text(
                                              "${event.title}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: event.isCompleted ? Colors.grey[600] : Colors.black,
                                                  decoration: event.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                                                  decorationThickness: 3),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          InkWell(
                                            onTap: () async {
                                              print("삭제누름");

                                              await ref.watch(mainProvider.notifier).notifyScheduleDelete(event.scheduleId!);

                                              scheduleDTOList.removeWhere((schedule) => schedule.id == event.scheduleId);

                                              List<Event>? selectedEvents = events[selectedDay];

                                              if (selectedEvents != null) {
                                                selectedEvents.remove(event);

                                                // 만약 해당 일자의 이벤트 목록이 더 이상 비어있지 않다면, events에 업데이트합니다.
                                                if (selectedEvents.isNotEmpty) {
                                                  events[selectedDay] = selectedEvents;
                                                } else {
                                                  // 이벤트 목록이 비어 있다면 해당 일자를 events에서 제거합니다.
                                                  events.remove(selectedDay);
                                                }
                                              }

                                              print("events : ${events}");
                                              print("events.runtimeType : ${events.runtimeType}");
                                              print("events[selectedDay] : ${events[selectedDay]}");

                                              // setState(() {});

                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AquariumDetailPage()));
                                            },
                                            child: Icon(Icons.delete_outline, color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                    child: Row(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.6),
                                          // width: sizeGetScreenWidth(context) * 0.6,
                                          child: Text(
                                            " ${event.title}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        InkWell(
                                          onTap: () async {
                                            print("삭제누름");

                                            await ref.watch(mainProvider.notifier).notifyScheduleDelete(event.scheduleId!);

                                            scheduleDTOList.removeWhere((schedule) => schedule.id == event.scheduleId);

                                            List<Event>? selectedEvents = events[selectedDay];

                                            if (selectedEvents != null) {
                                              selectedEvents.remove(event);

                                              // 만약 해당 일자의 이벤트 목록이 더 이상 비어있지 않다면, events에 업데이트합니다.
                                              if (selectedEvents.isNotEmpty) {
                                                events[selectedDay] = selectedEvents;
                                              } else {
                                                // 이벤트 목록이 비어 있다면 해당 일자를 events에서 제거합니다.
                                                events.remove(selectedDay);
                                              }
                                            }

                                            print("events : ${events}");
                                            print("events.runtimeType : ${events.runtimeType}");
                                            print("events[selectedDay] : ${events[selectedDay]}");

                                            // setState(() {});

                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AquariumDetailPage()));
                                          },
                                          child: Icon(Icons.delete_outline, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  );
                          }).toList(),
                        );
                },
              ),
            ),
            SizedBox(height: 5),
            Container(
              // height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text(
                        "${selectedDay.month < 10 ? "0${selectedDay.month}" : selectedDay.month}월 ${selectedDay.day < 10 ? "0${selectedDay.day}" : selectedDay.day}일 계획"),
                    style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10))),
                    onPressed: () {
                      _eventController.text = "";
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text("${selectedDay.month}월 ${selectedDay.day}일 계획 추가"),
                            content: TextField(controller: _eventController),
                            actions: [
                              ElevatedButton(
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                                onPressed: () async {
                                  if (_eventController.text == "") {
                                    return;
                                  }

                                  ScheduleRequestDTO scheduleRequestDTO =
                                      new ScheduleRequestDTO(title: _eventController.text, scheduleEnum: "지정", targetDay: selectedDay);

                                  await ref.watch(mainProvider.notifier).notifyScheduleCreate(aquariumDTO.id, scheduleRequestDTO);

                                  events[selectedDay] ??= [];
                                  events[selectedDay]!.add(Event(_eventController.text));

                                  // print(events);
                                  Navigator.of(context).pop();
                                  _selectedEvents.value = _getEventsForDay(selectedDay);
                                  setState(() {});
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AquariumDetailPage()));
                                  setState(() {});
                                  print("다시그림");
                                },
                                child: Text("제출"),
                              ),
                              SizedBox(width: 5),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Text("요일 반복 계획"),
                    style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10))),
                    onPressed: () {
                      _eventController.text = "";
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text("요일 반복 계획 추가"),
                            content: TextField(controller: _eventController),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildWeekInkWell(context, "월", 1),
                                  buildWeekInkWell(context, "화", 2),
                                  buildWeekInkWell(context, "수", 3),
                                  buildWeekInkWell(context, "목", 4),
                                  buildWeekInkWell(context, "금", 5),
                                  buildWeekInkWell(context, "토", 6),
                                  buildWeekInkWell(context, "일", 7),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Text("기간 반복 계획"),
                    style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10))),
                    onPressed: () {
                      _eventController.text = "";
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            title: Text("기간 반복 계획 추가"),
                            content: TextField(controller: _eventController),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildDayInkWell(context, "매일", 1),
                                  buildDayInkWell(context, "격일", 2),
                                  buildDayInkWell(context, "나흘", 4),
                                  buildDayInkWell(context, "열흘", 10),
                                  buildDayInkWell(context, "매월", 30),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildWeekInkWell(BuildContext context, String week, int dayInt) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text("${week}", style: TextStyle(color: Colors.white)),
      ),
      onTap: () async {
        if (_eventController.text == "") {
          return;
        }

        DateTime targetWeek = day0101;

        while (targetWeek.weekday != dayInt) {
          targetWeek = targetWeek.add(Duration(days: 1));
        }

        ScheduleRequestDTO scheduleRequestDTO = new ScheduleRequestDTO(title: _eventController.text, scheduleEnum: "요일", betweenDay: dayInt);

        await ref.watch(mainProvider.notifier).notifyScheduleCreate(aquariumDTO.id, scheduleRequestDTO);

        for (int i = 0; i < durationDay; i += 7) {
          events[targetWeek.add(Duration(days: i))] ??= [];
          events[targetWeek.add(Duration(days: i))]!.add(Event("${_eventController.text}"));
        }

        Navigator.of(context).pop();
        _selectedEvents.value = _getEventsForDay(selectedDay);
        setState(() {});
      },
    );
  }

  InkWell buildDayInkWell(BuildContext context, String week, int dayInt) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text("${week}", style: TextStyle(color: Colors.white)),
      ),
      onTap: () {
        if (_eventController.text == "") {
          return;
        }

        DateTime targetWeek = day0101;

        for (int i = 0; i < durationDay; i += dayInt) {
          events[targetWeek.add(Duration(days: i))] ??= [];
          events[targetWeek.add(Duration(days: i))]!.add(Event("${_eventController.text}"));
        }

        Navigator.of(context).pop();
        _selectedEvents.value = _getEventsForDay(selectedDay);
        setState(() {});
      },
    );
  }
}
