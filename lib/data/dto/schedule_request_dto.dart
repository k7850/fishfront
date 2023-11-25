import 'package:fishfront/data/model/book.dart';
import 'package:intl/intl.dart';

class ScheduleRequestDTO {
  String title;
  String scheduleEnum;
  int? betweenDay;
  DateTime? targetDay;

  ScheduleRequestDTO({required this.title, required this.scheduleEnum, this.betweenDay, this.targetDay});

  Map<String, dynamic> toJson() => {
        "title": title,
        "scheduleEnum": scheduleEnum,
        "betweenDay": betweenDay,
        "targetDay": targetDay.toString(),
      };

  @override
  String toString() {
    return 'ScheduleRequestDTO{title: $title, scheduleEnum: $scheduleEnum, betweenDay: $betweenDay, targetDay: $targetDay}';
  }
}
