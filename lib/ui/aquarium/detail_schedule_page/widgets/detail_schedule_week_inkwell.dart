import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/schedule_request_dto.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/detail_schedule_view_model.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/event.dart';
import 'package:fishfront/ui/aquarium/detail_tabbar_page/aquarium_detail_page.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScheduleWeekInkwell extends ConsumerWidget {
  String week;
  int dayInt;
  int importantly;

  DetailScheduleWeekInkwell(this.week, this.dayInt, this.importantly, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailScheduleModel model = ref.watch(detailScheduleProvider)!;

    TextEditingController _eventController = model.eventController;

    Map<DateTime, List<Event>> eventMap = model.eventMap;

    List<Event> selectedEventList = model.selectedEventList;

    DateTime day0101 = model.day0101;

    DateTime selectedDay = model.selectedDay;

    int durationDay = model.durationDay;

    AquariumDTO aquariumDTO = model.aquariumDTO;

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

        ScheduleRequestDTO scheduleRequestDTO =
            new ScheduleRequestDTO(title: _eventController.text, scheduleEnum: "요일", betweenDay: dayInt, importantly: importantly);

        await ref.read(mainProvider.notifier).notifyScheduleCreate(aquariumDTO.id, scheduleRequestDTO);

        for (int i = 0; i < durationDay; i += 7) {
          eventMap[targetWeek.add(Duration(days: i))] ??= [];
          eventMap[targetWeek.add(Duration(days: i))]!.add(Event(title: _eventController.text));
        }
        ref.read(detailScheduleProvider.notifier).notifyEventMap(eventMap);

        Navigator.pop(context);

        selectedEventList = eventMap[selectedDay] ?? [];
        // ref.read(detailScheduleProvider.notifier).notifySelectedEventList(selectedEventList);
        ref.read(detailScheduleProvider.notifier).notifyInit();

        // setState(() {});
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AquariumDetailPage()));
      },
    );
  }
}
