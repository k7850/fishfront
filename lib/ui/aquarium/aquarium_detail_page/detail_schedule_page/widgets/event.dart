class Event {
  final String title;
  bool isCompleted;
  int? scheduleId;

  Event(this.title, {this.isCompleted = false, this.scheduleId});

  @override
  String toString() {
    return "${title} ${isCompleted ? "완료" : ""}";
  }
}
