import 'package:fishfront/data/model/book.dart';
import 'package:intl/intl.dart';

class ScheduleRequestDTO {
  String title;
  String scheduleEnum;
  int? betweenDay;
  DateTime? targetDay;
  int importantly;

  ScheduleRequestDTO({
    required this.title,
    required this.scheduleEnum,
    this.betweenDay,
    this.targetDay,
    this.importantly = 1,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "scheduleEnum": scheduleEnum,
        "betweenDay": betweenDay,
        "targetDay": targetDay == null ? null : targetDay.toString(),
        "importantly": importantly,
      };

  @override
  String toString() {
    return 'ScheduleRequestDTO{title: $title, scheduleEnum: $scheduleEnum, betweenDay: $betweenDay, targetDay: $targetDay, importantly: $importantly}';
  }
}
