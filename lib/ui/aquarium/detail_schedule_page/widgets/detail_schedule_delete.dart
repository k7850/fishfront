import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/detail_schedule_view_model.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/event.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScheduleDelete extends ConsumerWidget {
  Event event;

  DetailScheduleDelete(this.event, {super.key});

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

    List<ScheduleDTO> scheduleDTOList = model.scheduleDTOList;

    return InkWell(
      onTap: () async {
        print("삭제누름");

        await ref.read(mainProvider.notifier).notifyScheduleDelete(event.scheduleId!);

        scheduleDTOList.removeWhere((schedule) => schedule.id == event.scheduleId);

        List<Event>? selectedEvents = eventMap[selectedDay];

        if (selectedEvents != null) {
          selectedEvents.remove(event);

          if (selectedEvents.isNotEmpty) {
            eventMap[selectedDay] = selectedEvents;
          } else {
            eventMap.remove(selectedDay);
          }
        }
        ref.read(detailScheduleProvider.notifier).notifyEventMap(eventMap);

        ref.read(detailScheduleProvider.notifier).notifyInit();
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AquariumDetailPage()));
      },
      child: Icon(Icons.delete_outline, color: Colors.red),
    );
  }
}
