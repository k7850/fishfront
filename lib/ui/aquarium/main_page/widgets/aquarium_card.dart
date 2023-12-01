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
    Column scheduleColumn = Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${today.month}월 ${today.day}일 오늘의 어항 관리",
          ),
        )
      ],
    );

    for (ScheduleDTO scheduleDTO in widget.aquariumDTO.scheduleDTOList) {
      if (scheduleDTO.scheduleEnum == "지정") {
        // print(scheduleDTO.targetDay);
        DateFormat('yyyy-MM-dd').format(today) == DateFormat('yyyy-MM-dd').format(scheduleDTO.targetDay!)
            ? scheduleColumn.children.add(buildScheduleCheck(scheduleDTO))
            : ();
      }
      if (scheduleDTO.scheduleEnum == "요일") {
        today.weekday == scheduleDTO.betweenDay //
            ? scheduleColumn.children.add(buildScheduleCheck(scheduleDTO))
            : ();
      }
      if (scheduleDTO.scheduleEnum == "간격") {
        if (scheduleDTO.betweenDay == 1) scheduleColumn.children.add(buildScheduleCheck(scheduleDTO));
      }
    }

    if (scheduleColumn.children.length == 1) {
      scheduleColumn.children.removeAt(0);
      scheduleColumn.children.add(
        Text("오늘의 계획 없음"),
      );
    }

    return Container(
      margin: EdgeInsets.only(left: 20),
      width: sizeGetScreenWidth(context) * 0.7,
      // height: sizeGetScreenHeight(context) * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: idColorMage(widget.aquariumDTO.id),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Center(child: Text("${widget.aquariumDTO.title}", style: TextStyle(fontSize: 25), maxLines: 1)),
          SizedBox(height: 5),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "$imageURL${widget.aquariumDTO.photo}",
                width: sizeGetScreenWidth(context) * 0.6,
                height: sizeGetScreenWidth(context) * 0.6,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/aquarium.png",
                    width: sizeGetScreenWidth(context) * 0.6,
                    height: sizeGetScreenWidth(context) * 0.6,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Text(
              "${widget.aquariumDTO.intro}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(color: Colors.black, height: 1, thickness: 1),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(child: scheduleColumn),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  //

  Widget buildScheduleCheck(ScheduleDTO scheduleDTO) {
    return InkWell(
      onTap: () async {
        print("체크누름");
        await ref.watch(mainProvider.notifier).notifyScheduleCheck(scheduleDTO.id, scheduleDTO.isCompleted);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Row(
          children: [
            scheduleDTO.isCompleted ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
            SizedBox(width: 5),
            Container(
              width: sizeGetScreenWidth(context) * 0.5,
              child: Text(
                "${scheduleDTO.title}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: scheduleDTO.isCompleted ? Colors.grey[600] : Colors.black,
                    decoration: scheduleDTO.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                    decorationThickness: 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color idColorMage(int id) {
  int colorChange(int colorInt) {
    colorInt %= 255;
    while (colorInt < 50) {
      colorInt += 10;
    }
    while (colorInt > 200) {
      colorInt -= 10;
    }
    return colorInt;
  }

  return Color.fromRGBO(colorChange(id * 55), colorChange(id * 155), colorChange(id * 222), 0.5);
}
