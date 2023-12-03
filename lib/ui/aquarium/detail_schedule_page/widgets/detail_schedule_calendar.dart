import 'package:fishfront/ui/aquarium/detail_schedule_page/detail_schedule_view_model.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/event.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailScheduleCalendar extends ConsumerWidget {
  const DetailScheduleCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailScheduleModel model = ref.watch(detailScheduleProvider)!;

    DateTime day0101 = model.day0101;
    DateTime selectedDay = model.selectedDay;
    int durationDay = model.durationDay; // 3년

    bool toggleFood = model.toggleFood;
    bool toggleWaterChange = model.toggleWaterChange;
    bool toggleImportant = model.toggleImportant;

    Map<DateTime, List<Event>> eventMap = model.eventMap;

    List<Event> selectedEventList = model.selectedEventList;

    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe, // 달력 자체의 위-아래 스크롤 끄기
      locale: 'ko_KR',
      firstDay: DateTime.utc(DateTime.now().year - 1, 01, 01),
      lastDay: day0101.add(Duration(days: durationDay)),
      focusedDay: selectedDay,
      rowHeight: 45,
      headerStyle: const HeaderStyle(
        titleCentered: true,
        // titleTextFormatter: (date, locale) => DateFormat.yMMMMd(locale).format(selectedDay),
        // leftChevronIcon: const Icon(Icons.arrow_left, size: 40.0),
        // rightChevronIcon: const Icon(Icons.arrow_right, size: 40.0),
        formatButtonVisible: false,
        titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
        headerPadding: EdgeInsets.only(bottom: 5),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          if (events.isEmpty) return const SizedBox();
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: events.length,
              itemBuilder: (context, index) {
                print(events[0]);
                print(events[0].toString());
                return Container(
                  margin: const EdgeInsets.only(top: 25),
                  padding: const EdgeInsets.all(1),
                  child: events[index].toString().contains("importantly: 1") && toggleFood && events[index].toString().contains("diaryId: null")
                      ? const SizedBox()
                      : events[index].toString().contains("importantly: 2") && toggleWaterChange
                          ? const SizedBox()
                          : events[index].toString().contains("importantly: 3") && toggleImportant
                              ? const SizedBox()
                              : events[index].toString().contains("diaryId: null")
                                  ? Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: events[index].toString().contains("importantly: 1")
                                          ? Colors.black38
                                          : events[index].toString().contains("importantly: 2")
                                              ? Colors.green[600]
                                              : Colors.red[300],
                                    )
                                  : const Icon(Icons.star, size: 13, color: Colors.indigoAccent),
                  // Container(
                  //     width: 8,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: events[index].toString().contains("importantly: 1")
                  //           ? Colors.black38
                  //           : events[index].toString().contains("importantly: 2")
                  //               ? Colors.green[600]
                  //               : Colors.red[300],
                  //     ),
                  //   ),
                );
              });
        },
      ),
      calendarStyle: CalendarStyle(
        // markerDecoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        todayDecoration: BoxDecoration(color: Colors.yellow[200], shape: BoxShape.circle),
        todayTextStyle: const TextStyle(fontSize: 20),
        selectedDecoration: const BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
        selectedTextStyle: const TextStyle(fontSize: 20),
      ),
      onDaySelected: (selected, focusedDay) {
        selectedDay = selected;
        selectedEventList = eventMap[selectedDay] ?? [];
        // print("selectedEventList : ${selectedEventList}");
        // print("eventMap[selectedDay] : ${eventMap[selectedDay]}");
        ref.read(detailScheduleProvider.notifier).notifySelectedDay(selected);
        ref.read(detailScheduleProvider.notifier).notifySelectedEventList(eventMap[selectedDay] ?? []);
        // setState(() {});
      },
      selectedDayPredicate: (day) => isSameDay(day, selectedDay),
      eventLoader: (day) {
        return eventMap[day] ?? [];
      },
    );
  }
}
