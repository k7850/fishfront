import 'package:intl/intl.dart';

String buildTime(DateTime? time) {
  DateTime now = DateTime.now();

  return time == null
      ? "오류"
      : now.difference(time).inDays >= 7
          ? "${DateFormat.yMMMMd("ko").format(time)}"
          : now.difference(time).inDays >= 1
              ? "${now.difference(time).inDays}일 전 "
              : now.difference(time).inHours >= 1
                  ? "${now.difference(time).inHours}시간 전 "
                  : now.difference(time).inMinutes >= 1
                      ? "${now.difference(time).inMinutes}분 전 "
                      : now.difference(time).inSeconds >= 10
                          ? "${now.difference(time).inSeconds}초 전 "
                          : "지금";
}
