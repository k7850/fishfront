import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/dto/schedule_request_dto.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/detail_schedule_view_model.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/detail_schedule_delete.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/event.dart';
import 'package:fishfront/ui/aquarium/detail_tabbar_page/aquarium_detail_page.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScheduleTodayCheck extends ConsumerWidget {
  Event event;

  DetailScheduleTodayCheck(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailScheduleModel model = ref.watch(detailScheduleProvider)!;

    Map<DateTime, List<Event>> eventMap = model.eventMap;

    List<ScheduleDTO> scheduleDTOList = model.scheduleDTOList;

    return InkWell(
      onTap: () async {
        for (ScheduleDTO schedule in scheduleDTOList) {
          if (schedule.id == event.scheduleId) {
            await ref.read(mainProvider.notifier).notifyScheduleCheck(schedule.id, schedule.isCompleted);
            event.isCompleted = !event.isCompleted;
            ref.read(detailScheduleProvider.notifier).notifyEventMap(eventMap);
          }
        }
        // setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            event.isCompleted ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
            const SizedBox(width: 5),
            Container(
              constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.6),
              child: Text(
                event.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: event.importantly == 3
                      ? Colors.red[400]
                      : event.importantly == 2
                          ? Colors.green[600]
                          : Colors.grey[600],
                  decoration: event.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationThickness: 3,
                  decorationColor: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 5),
            DetailScheduleDelete(event),
          ],
        ),
      ),
    );
  }
}
