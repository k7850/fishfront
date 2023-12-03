import 'package:fishfront/ui/aquarium/detail_schedule_page/detail_schedule_view_model.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/detail_schedule_otherday_check.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/detail_schedule_today_check.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DetailScheduleShowSchedule extends ConsumerWidget {
  const DetailScheduleShowSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailScheduleModel? model = ref.watch(detailScheduleProvider)!;

    DateTime selectedDay = model.selectedDay;

    List<Event> selectedEventList = model.selectedEventList;

    return Container(
      // constraints: BoxConstraints(minHeight: 40),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.green.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(DateFormat.yMMMMd("ko").format(selectedDay)),
          if (selectedDay.year == DateTime.now().year && selectedDay.month == DateTime.now().month && selectedDay.day == DateTime.now().day) //
            Text("오늘", style: TextStyle(color: Colors.grey[700], fontSize: 17)),
          if (selectedEventList.isEmpty) //
            Text("일정 없음", style: TextStyle(color: Colors.grey[700], fontSize: 17)),
          for (Event event in selectedEventList)
            DateTime.now().day == selectedDay.day && DateTime.now().month == selectedDay.month && DateTime.now().year == selectedDay.year
                ? DetailScheduleTodayCheck(event)
                : DetailScheduleOtherdayCheck(event),
        ],
      ),
    );
  }
}
