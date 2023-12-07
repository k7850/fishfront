import 'package:fishfront/ui/_common_widgets/format_day.dart';
import 'package:fishfront/ui/_common_widgets/id_color_make.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../_core/constants/http.dart';
import '../../../../_core/constants/size.dart';
import '../../../../data/dto/aquarium_dto.dart';
import '../../../../data/dto/schedule_dto.dart';

class AquariumCard extends ConsumerStatefulWidget {
  const AquariumCard({
    super.key,
    required this.aquariumDTO,
  });

  final AquariumDTO aquariumDTO;

  @override
  _AquariumCardState createState() => _AquariumCardState();
}

class _AquariumCardState extends ConsumerState<AquariumCard> {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();

    Column scheduleColumn = Column(children: []);

    for (ScheduleDTO scheduleDTO in widget.aquariumDTO.scheduleDTOList) {
      // print(scheduleDTO);
      if (scheduleDTO.scheduleEnum == "지정") {
        if (DateFormat('yyyy-MM-dd').format(today) == DateFormat('yyyy-MM-dd').format(scheduleDTO.targetDay!)) {
          scheduleColumn.children.add(buildScheduleCheck(scheduleDTO));
        }
      }
      if (scheduleDTO.scheduleEnum == "요일") {
        if (today.weekday == scheduleDTO.betweenDay) {
          scheduleColumn.children.add(buildScheduleCheck(scheduleDTO));
        }
      }
      if (scheduleDTO.scheduleEnum == "간격") {
        DateTime startDay = formatDay(scheduleDTO.targetDay!);

        print("실행시작 : ${scheduleDTO}");

        int i = 0;
        bool check = false;

        while (!check) {
          DateTime currentDate = startDay.add(Duration(days: i));
          i = i + scheduleDTO.betweenDay!;

          if (currentDate.isBefore(DateTime.now().add(Duration(days: -1)))) {
            print("이전 계속진행");
            continue;
          }

          print("currentDate : ${currentDate}");
          print("DateTime.now() : ${DateTime.now()}");
          if (currentDate.year == DateTime.now().year && currentDate.month == DateTime.now().month && currentDate.day == DateTime.now().day) {
            scheduleColumn.children.add(buildScheduleCheck(scheduleDTO));
            check = true;
            print("맞음");
            break;
          }

          if (currentDate.isAfter(DateTime.now())) {
            check = true;
            print("지남");
            break;
          }
          print("계속반복");
        }
      }
    }

    if (scheduleColumn.children.isEmpty) {
      scheduleColumn.children.add(
        const Text("오늘의 계획 없음"),
      );
    } else {
      scheduleColumn.children.insert(
        0,
        Align(
          alignment: Alignment.centerLeft,
          child: Text("${today.month}월 ${today.day}일 오늘의 어항 관리"),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(left: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: sizeGetScreenWidth(context) * 0.7,
      // height: sizeGetScreenHeight(context) * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: idColorMake(widget.aquariumDTO.id),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Center(child: Text("${widget.aquariumDTO.title}", style: const TextStyle(fontSize: 25), maxLines: 1)),
          const SizedBox(height: 5),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "$imageURL${widget.aquariumDTO.photo}",
                height: sizeGetScreenWidth(context) * 0.5,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/aquarium.png",
                    height: sizeGetScreenWidth(context) * 0.5,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${widget.aquariumDTO.intro}",
            style: TextStyle(color: Colors.grey[700]),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.black, height: 1, thickness: 1),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(child: scheduleColumn),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildScheduleCheck(ScheduleDTO scheduleDTO) {
    return InkWell(
      onTap: () async {
        print("체크누름");
        await ref.watch(mainProvider.notifier).notifyScheduleCheck(scheduleDTO.id, scheduleDTO.isCompleted);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Row(
          children: [
            scheduleDTO.isCompleted ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
            const SizedBox(width: 5),
            SizedBox(
              width: sizeGetScreenWidth(context) * 0.5,
              child: Text(
                "${scheduleDTO.title}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: scheduleDTO.importantly == 3
                      ? Colors.red[400]
                      : scheduleDTO.importantly == 2
                          ? Colors.green[600]
                          : Colors.grey[600],
                  decoration: scheduleDTO.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationThickness: 3,
                  decorationColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
