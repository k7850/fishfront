import 'package:fishfront/ui/_common_widgets/week_int_to_string.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/detail_schedule_view_model.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../data/dto/schedule_dto.dart';

class AllSchedule extends ConsumerStatefulWidget {
  const AllSchedule({
    super.key,
    required this.scheduleDTOList,
  });

  final List<ScheduleDTO> scheduleDTOList;

  @override
  ConsumerState<AllSchedule> createState() => _AllScheduleState();
}

class _AllScheduleState extends ConsumerState<AllSchedule> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.yellow[300]),
      // constraints: const BoxConstraints(minHeight: 60),
      child: Column(
        children: [
          // const Divider(color: Colors.grey, height: 30, thickness: 1),
          const SizedBox(height: 10),
          isOpen
              ? InkWell(
                  onTap: () => setState(() => isOpen = false),
                  child: const Text("전체 일정 접기 ▲", style: TextStyle(fontSize: 18)),
                )
              : InkWell(
                  onTap: () => setState(() => isOpen = true),
                  child: const Text("전체 일정 펼치기 ▼", style: TextStyle(fontSize: 18)),
                ),
          const SizedBox(height: 10),
          if (isOpen)
            for (var schedule in widget.scheduleDTOList)
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${schedule.title}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18,
                            color: schedule.importantly == 3
                                ? Colors.red[400]
                                : schedule.importantly == 2
                                    ? Colors.green[600]
                                    : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () async {
                            await ref.read(mainProvider.notifier).notifyScheduleDelete(schedule.id);
                            ref.read(detailScheduleProvider.notifier).notifyInit();
                          },
                          child: const Icon(Icons.delete_outline, color: Colors.red),
                        ),
                      ],
                    ),
                    schedule.scheduleEnum == "지정"
                        ? Text("${DateFormat.yMMMMd("ko").format(schedule.targetDay!)} ")
                        : schedule.scheduleEnum == "요일"
                            ? Text("매 주 ${weekIntToString(schedule.betweenDay!)} 반복")
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${schedule.betweenDay}일 간격 반복"),
                                  Text(
                                    " (${DateFormat.yMMMMd("ko").format(schedule.targetDay!)}부터)",
                                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                  ),
                                ],
                              ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
