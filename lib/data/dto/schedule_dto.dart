import 'package:fishfront/data/model/book.dart';
import 'package:intl/intl.dart';

class ScheduleDTO {
  int id;
  int aquariumId;
  String aquariumTitle;
  String title;
  String scheduleEnum;
  bool isCompleted;
  int? betweenDay;
  DateTime? targetDay;
  DateTime createdAt;
  DateTime updatedAt;
  int importantly;

  ScheduleDTO(this.id, this.aquariumId, this.aquariumTitle, this.title, this.scheduleEnum, this.isCompleted, this.betweenDay, this.targetDay,
      this.createdAt, this.updatedAt, this.importantly);

  ScheduleDTO.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        aquariumId = json["aquariumId"],
        aquariumTitle = json["aquariumTitle"],
        title = json["title"],
        scheduleEnum = json["scheduleEnum"],
        isCompleted = json["isCompleted"],
        betweenDay = json["betweenDay"],
        importantly = json["importantly"],
        targetDay = json["targetDay"] == null ? null : DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["targetDay"]),
        createdAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["createdAt"]),
        updatedAt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(json["updatedAt"]);

  @override
  String toString() {
    return 'ScheduleDTO{id: $id, aquariumId: $aquariumId, aquariumTitle: $aquariumTitle, title: $title, scheduleEnum: $scheduleEnum, isCompleted: $isCompleted, betweenDay: $betweenDay, targetDay: $targetDay, createdAt: $createdAt, updatedAt: $updatedAt, importantly: $importantly}';
  }
}
