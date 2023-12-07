import 'package:intl/intl.dart';

DateTime formatDay(DateTime target) {
  String formattedDate = DateFormat('yyyy-MM-dd 00:00:00.000Z').format(target);
  DateTime parsedDate = DateFormat('yyyy-MM-dd 00:00:00.000Z').parseUTC(formattedDate);
  return parsedDate;
}
