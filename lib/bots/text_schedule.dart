import 'dart:async';

import 'package:ar_core_intro/bots/monthnday.dart';

class Scheduler {
  getTime() {
    var currentTime = DateTime.now();
    List availableMinutes = [];
    List availableHours = [];
    List availableDays = [];
    for (var i = currentTime.minute + 1; i < 60; i++) {
      availableMinutes.add(i);
    }
    print(availableMinutes);
    for (var i = currentTime.hour; i < 24; i++) {
      availableHours.add(i);
    }
    print(availableHours);
    String currentMonth = Numberify().findMonthName(currentTime.month);
    String nextMonth = Numberify()
        .findMonthName(currentTime.month == 12 ? 1 : currentTime.month + 1);
    print(currentMonth);
    print(nextMonth);

    var daysInTheMonth =
        Numberify().getNoofDaysInMonth(currentTime.month, currentTime.year);
    print(daysInTheMonth);
    for (var i = currentTime.day; i <= daysInTheMonth; i++) {
      availableDays.add(i);
    }
    print(availableDays);
    daysInTheMonth = Numberify().getNoofDaysInMonth(
        currentTime.month == 12 ? 1 : currentTime.month + 1,
        currentTime.month == 12 ? currentTime.year + 1 : currentTime.year);
    print(daysInTheMonth);
    List availabledaysNextMonth = [];
    for (var i = 1; i <= daysInTheMonth; i++) {
      availabledaysNextMonth.add(i);
    }

    List toreturn = [
      // list containing the minutes left in the present hour
      availableMinutes,
      // list containing the hours left in the present day
      availableHours,
      // string name of the present month
      currentMonth,
      // list of the available days in the current month
      availableDays,
      // string name of the next month
      nextMonth,
      // list of the next days in the current month
      availabledaysNextMonth
    ];
    print(toreturn);
    return toreturn;
  }

  scheduleMessage(String month, int day, int hour, int min) {
    int monthNo = Numberify().convertMonthToNumber(month);
    var currentTime = DateTime.now();
    int currentMin = currentTime.minute;
    int currentHour = currentTime.hour;
    int currentDay = currentTime.day;
    int currentMon = currentTime.month;
    var diffInMin = 0;
    if (monthNo == currentMon && day == currentDay && hour == currentHour) {
      diffInMin = min - currentMin;
    } else if (monthNo == currentMon && day == currentDay) {
      diffInMin = (60 - currentMin) + (hour - currentHour - 1) * 60 + min;
    } else if (monthNo == currentMon) {
      diffInMin = (60 - currentMin) +
          (24 - currentHour - 1) * 60 +
          (day - currentDay - 1) * 24 * 60 +
          60 * hour +
          min;
    } else {
      diffInMin = (60 - currentMin) +
          (24 - currentHour - 1) * 60 +
          (Numberify().getNoofDaysInMonth(currentTime.month, currentTime.year) -
                  currentDay -
                  1) *
              24 *
              60 +
          day * 24 * 60 +
          hour * 60 +
          min;
    }
    Timer(Duration(minutes: diffInMin), () {
      // this will be entered when the time is reached
      // here we will call the function which will send the message
    });
  }
}
