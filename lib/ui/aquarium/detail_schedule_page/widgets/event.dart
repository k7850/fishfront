class Event {
  final String title;
  bool isCompleted;
  int? scheduleId;
  int importantly;
  int? diaryId;

  Event({required this.title, this.isCompleted = false, this.scheduleId, this.importantly = 1, this.diaryId});

  @override
  String toString() {
    return 'Event{title: $title, isCompleted: $isCompleted, scheduleId: $scheduleId, importantly: $importantly, diaryId: $diaryId}';
  }
}
