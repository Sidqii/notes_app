import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String notesDateFormatter(DateTime time) {
  return timeago.format(time, locale: 'id');
}

String notesFormalFormatter(DateTime time) {
  return DateFormat('d MMM, yyy').format(time.toLocal());
}
