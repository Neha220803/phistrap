

import 'package:intl/intl.dart';

String formatDuration(int? seconds) {
  if (seconds == null) return 'Unknown';
  final Duration duration = Duration(seconds: seconds);
  return duration.toString().split('.').first.padLeft(8, "0");
}

String formatTime(int? timestamp) {
  if (timestamp == null) return 'Unknown';
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}
