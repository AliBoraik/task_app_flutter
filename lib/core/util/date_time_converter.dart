import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayConverter on TimeOfDay {
  TimeOfDay addhours(int hours) {
    var currentHour = hour + hours;
    if (currentHour < 0) {
      currentHour = 23;
    }
    return TimeOfDay(hour: currentHour, minute: minute);
  }
}

extension DateTimeExtension on DateTime {
  DateTime setTimeOfDay(TimeOfDay time) {
    // Convert the TimeOfDay to 24-hour format
    int hour = time.hourOfPeriod;
    if (time.period == DayPeriod.pm) {
      hour += 12;
    }
    return DateTime(year, month, day, hour, time.minute);
  }

  TimeOfDay toTimeOfDay({int minute = 0}) {
    return TimeOfDay(hour: hour, minute: minute);
  }

  String toDMYformattedString() {
    final format = DateFormat('dd/MM/yyyy');
    return format.format(this);
  }
}
