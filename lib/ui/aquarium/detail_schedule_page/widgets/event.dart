class Event {
  final String title;
  bool isCompleted;
  int? scheduleId;
  int importantly;

  Event({required this.title, this.isCompleted = false, this.scheduleId, this.importantly = 1});

  @override
  String toString() {
    return 'Event{title: $title, isCompleted: $isCompleted, scheduleId: $scheduleId, importantly: $importantly}';
  }
}
