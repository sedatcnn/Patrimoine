import 'package:intl/intl.dart';
import 'package:patrimonie/model/date_model.dart';

List<DateModel> getDates() {
  List<DateModel> dates = [];
  DateTime now = DateTime.now();
  int currentDay = now.day;
  final List<String> turkishDays = [
    'Pzt',
    'Sal',
    'Çar',
    'Per',
    'Cum',
    'Cmt',
    'Paz',
  ];
  for (int i = 0; i < 7; i++) {
    DateModel dateModel = DateModel();
    DateTime date = now.add(Duration(days: i));

    dateModel.gunler_ = DateFormat('E').format(date);
    dateModel.tarih_ = DateFormat('d').format(date);
    dateModel.isCurrentDay = date.day == currentDay;
    int dayOfWeek = (date.weekday - 1 + 7) % 7;
    dateModel.gunler_ = turkishDays[dayOfWeek];
    if (date.month == DateTime.february && date.day > 28) {
      if (isLeapYear(date.year)) {
        dateModel.tarih_ = '29';
      } else {
        dateModel.tarih_ = '28';
      }
    }

    dates.add(dateModel);
  }

  return dates;
}

bool isLeapYear(int year) {
  if (year % 4 != 0) {
    return false;
  } else if (year % 100 == 0 && year % 400 != 0) {
    return false;
  }
  return true;
}

List<TimeModel> getTimes() {
  List<TimeModel> times = [];
  for (int hour = 0; hour < 24; hour++) {
    String formattedHour = hour.toString().padLeft(2, '0');
    TimeModel timeModel = TimeModel(saat: hour, saatFormati: formattedHour);
    times.add(timeModel);
  }
  return times;
}
