import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/dto/schedule_request_dto.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/detail_schedule_view_model.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/detail_schedule_bottomsheet.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/detail_schedule_delete.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/event.dart';
import 'package:fishfront/ui/aquarium/detail_tabbar_page/aquarium_detail_page.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScheduleOtherdayCheck extends ConsumerWidget {
  Event event;

  DetailScheduleOtherdayCheck(this.event, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return event.diaryId != null
        ? InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                builder: (BuildContext context) {
                  return DetailScheduleBottomsheet(event.diaryId!);
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Text(event.title, style: const TextStyle(color: Colors.indigoAccent)),
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.6),
                  child: Text(
                    " ${event.title}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: event.isCompleted
                            ? Colors.grey[600]
                            : event.importantly == 3
                                ? Colors.red[400]
                                : event.importantly == 2
                                    ? Colors.green[600]
                                    : Colors.black,
                        decoration: event.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                        decorationThickness: 3),
                  ),
                ),
                const SizedBox(width: 5),
                DetailScheduleDelete(event),
              ],
            ),
          );
  }
}
