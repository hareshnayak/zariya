import 'package:cloud_firestore/cloud_firestore.dart';

String addZeroToInt(int i) {
  String result;
  if (i < 10)
    result = '0$i';
  else
    result = '$i';
  return result;
}

String getDateString(dynamic data) {
  String date;
  if (data.runtimeType == Timestamp) {
    DateTime dateTime = data.toDate();
    date =
        '${addZeroToInt(dateTime.day)}/${addZeroToInt(dateTime.month)}/${dateTime.year}';
  } else if (data.runtimeType == DateTime) {
    date = '${addZeroToInt(data.day)}/${addZeroToInt(data.month)}/${data.year}';
  }
  return date;
}

int convertTo12Hr(int i) {
  if (i > 12) i -= 12;
  return i;
}

String getAmPm(DateTime d) {
  String result;
  if (d.hour >= 12)
    result = 'pm';
  else
    result = 'am';
  return result;
}

String getTimeString(dynamic data) {
  String time;
  if (data.runtimeType == DateTime) {
    time =
        '${addZeroToInt(convertTo12Hr(data.hour))}:${addZeroToInt(data.minute)}${getAmPm(data)}';
  } else if (data.runtimeType == Timestamp) {
    DateTime dateTime = data.toDate();
    time =
        '${addZeroToInt(convertTo12Hr(dateTime.hour))}:${addZeroToInt(dateTime.minute)}${getAmPm(dateTime)}';
  }
  return time;
}
