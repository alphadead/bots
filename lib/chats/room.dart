import 'dart:async';

import 'package:ar_core_intro/operation/alarms.dart';
import 'package:ar_core_intro/operation/handle._inp.dart';
import 'package:ar_core_intro/operation/setting.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Divyam", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Adarsh, I am doing fine dude. wbu?",
        messageType: "sender"),
  ];
  sendMsg(String val) {
    setState(() {
      messages.add(ChatMessage(messageContent: val, messageType: 'sender'));
    });
    print(messages.length);
  }

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String search = '';
    final _formKey = GlobalKey<FormState>();
    final Handle find = new Handle();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Adarsh",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: messages.length,
            padding: EdgeInsets.only(top: 10, bottom: 80),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextField(
                        autofocus: true,
                        controller: textEditingController,
                        // onChanged: (value) {
                        //   setState(() {
                        //     search = textEditingController.text;
                        //   });
                        // },
                        onSubmitted: (String val) {
                          setState(() {
                            search = textEditingController.text;
                            textEditingController.clear();
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      if (textEditingController.text.contains('/movies')) {
                        String search = textEditingController.text.substring(8);
                        var mess = find.movieList(search);
                        setState(() {
                          mess.then((value) => {
                                messages.add(ChatMessage(
                                    messageContent: value.toString(),
                                    messageType: 'sender')),
                                print(value)
                              });
                        });
                      } else if (textEditingController.text
                          .contains('/github')) {
                        String search = textEditingController.text.substring(8);
                        var mess = find.github(search);

                        setState(() {
                          mess.then((value) => {
                                messages.add(ChatMessage(
                                    messageContent: value.toString(),
                                    messageType: 'sender')),
                                print(value)
                              });
                        });
                      } else if (textEditingController.text
                          .contains('/meaning')) {
                        String search = textEditingController.text.substring(9);
                        var mess = find.getMeaning(search);
                        setState(() {
                          mess.then((value) => {
                                messages.add(ChatMessage(
                                    messageContent: value.toString(),
                                    messageType: 'sender')),
                                print(value)
                              });
                        });
                      } else if (textEditingController.text.contains("+") ||
                          textEditingController.text.contains("-") ||
                          textEditingController.text.contains("*") ||
                          textEditingController.text.contains("/") ||
                          textEditingController.text.contains("^")) {
                        var cal = find.calculate(textEditingController.text);
                        setState(() {
                          messages.add(ChatMessage(
                              messageContent:
                                  textEditingController.text + ' = $cal',
                              messageType: 'sender'));
                        });
                      } else if (textEditingController.text
                          .contains('/recommend')) {
                        String search =
                            textEditingController.text.substring(11);
                        var mess = find.recommendMovie(search);
                        setState(() {
                          mess.then((value) => {
                                messages.add(ChatMessage(
                                    messageContent: value.toString(),
                                    messageType: 'sender')),
                                print(value)
                              });
                        });
                      } else if (textEditingController.text != '')
                        sendMsg(textEditingController.text);
                    },
                    child: GestureDetector(
                      onLongPress: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 300,
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Column(
                                        children: [
                                          // Text(time.toString()),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shadowColor: Colors.blue),
                                              onPressed: () {
                                                scheduling();
                                                setState(() {
                                                  isTrue = false;
                                                });
                                              },
                                              child: Text("Click")),
                                          isTrue
                                              ? Text("")
                                              : Row(
                                                  children: [
                                                    DropdownButton<dynamic>(
                                                      items: month,
                                                      value: currentMonth,
                                                      onChanged: (value) {
                                                        updateEverything(value);
                                                      },
                                                    ),
                                                    DropdownButton<dynamic>(
                                                        items: days,
                                                        value: currentDay,
                                                        onChanged: (value) {
                                                          checkDay(value);
                                                        }),
                                                    DropdownButton<dynamic>(
                                                        items: hour,
                                                        value: currentHour,
                                                        onChanged: (value) {
                                                          checkHour(value);
                                                        }),
                                                    DropdownButton<dynamic>(
                                                        items: min,
                                                        value: currentMin,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            currentMin = value;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                          isTrue
                                              ? Text("")
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    Scheduler().scheduleMessage(
                                                        currentMonth,
                                                        currentDay,
                                                        currentHour,
                                                        currentMin);
                                                  },
                                                  child: Text(
                                                      "Schedule message for $currentMonth $currentDay $currentHour:$currentMin"))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem> month = [];
  List<DropdownMenuItem> days = [];
  List<DropdownMenuItem> hour = [];
  List<DropdownMenuItem> min = [];
  var isTrue = true;
  var currentMonth = "";
  var presentMonth = "";
  var presentDay = 0;
  var presentHour = 0;
  var nextMonth = "";
  var currentDay = 0;
  var currentHour = 0;
  var currentMin = 0;

  checkDay(var value) {
    var hh = Scheduler().getTime();
    setState(() {
      min = [];
      hour = [];
      if (currentMonth == presentMonth && value == presentDay) {
        updateHourHalf(hh);
        updateMinHalf(hh);
        currentMin = hh[0][0];
        currentHour = hh[1][0];
      } else {
        updateHourFull();
        updateMinFull();
      }
      currentDay = value;
    });
  }

  updateMinFull() {
    min = [];
    for (var i = 0; i < 60; i++) {
      min.add(DropdownMenuItem(child: Text(i.toString()), value: i));
    }
  }

  updateHourFull() {
    hour = [];
    for (var i = 0; i <= 23; i++) {
      hour.add(DropdownMenuItem(child: Text(i.toString()), value: i));
    }
  }

  updateMinHalf(var hh) {
    min = [];
    for (var item in hh[0]) {
      min.add(DropdownMenuItem(child: Text(item.toString()), value: item));
    }
  }

  updateHourHalf(var hh) {
    hour = [];
    for (var item in hh[1]) {
      hour.add(DropdownMenuItem(child: Text(item.toString()), value: item));
    }
  }

  updateDays(var hh, var index) {
    days = [];
    for (var item in hh[index]) {
      days.add(DropdownMenuItem(child: Text(item.toString()), value: item));
    }
  }

  checkHour(var value) {
    var hh = Scheduler().getTime();
    setState(() {
      if (presentDay == currentDay &&
          presentMonth == currentMonth &&
          value == presentHour) {
        min = [];
        updateMinHalf(hh);
        currentMin = hh[0][0];
      } else {
        min = [];
        updateMinFull();
      }
      currentHour = value;
    });
  }

  updateEverything(var month) {
    var hh = Scheduler().getTime();
    setState(() {
      days = [];
      hour = [];
      min = [];
      if (month == presentMonth) {
        updateDays(hh, 3);
        updateHourHalf(hh);
        updateMinHalf(hh);
        currentMin = hh[0][0];
        currentHour = hh[1][0];
        currentDay = hh[3][0];
      } else {
        updateDays(hh, 5);
        updateHourFull();
        updateMinFull();
      }
      currentMonth = month;
    });
  }

  scheduling() {
    var hh = Scheduler().getTime();
    setState(() {
      month = [];
      min = [];
      hour = [];
      days = [];
      presentMonth = hh[2];
      nextMonth = hh[4];
      month.add(DropdownMenuItem(child: Text(hh[2]), value: hh[2]));
      month.add(DropdownMenuItem(child: Text(hh[4]), value: hh[4]));
      updateDays(hh, 3);
      updateHourHalf(hh);
      updateMinHalf(hh);
      currentMonth = hh[2];
      currentMin = hh[0][0];
      currentHour = hh[1][0];
      presentHour = hh[1][0];
      currentDay = hh[3][0];
      presentDay = hh[3][0];
    });
  }
}

class Scheduler {
  getTime() {
    var currentTime = DateTime.now();
    List availableMinutes = [];
    List availableHours = [];
    List availableDays = [];
    for (var i = currentTime.minute + 1; i < 60; i++) {
      availableMinutes.add(i);
    }
    for (var i = currentTime.hour; i <= 23; i++) {
      availableHours.add(i);
    }
    String currentMonth = Numberify().findMonthName(currentTime.month);
    String nextMonth = Numberify()
        .findMonthName(currentTime.month == 12 ? 1 : currentTime.month + 1);

    var daysInTheMonth =
        Numberify().getNoofDaysInMonth(currentTime.month, currentTime.year);
    for (var i = currentTime.day; i <= daysInTheMonth; i++) {
      availableDays.add(i);
    }
    daysInTheMonth = Numberify().getNoofDaysInMonth(
        currentTime.month == 12 ? 1 : currentTime.month + 1,
        currentTime.month == 12 ? currentTime.year + 1 : currentTime.year);
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
      print("Message after timer reached");
    });
  }
}

class Numberify {
  convertMonthToNumber(String month) {
    int no = 0;
    switch (month) {
      case "Jan":
        no = 1;
        break;
      case "Feb":
        no = 2;
        break;
      case "Mar":
        no = 3;
        break;
      case "Apr":
        no = 4;
        break;
      case "May":
        no = 5;
        break;
      case "Jun":
        no = 6;
        break;
      case "Jul":
        no = 7;
        break;
      case "Aug":
        no = 8;
        break;
      case "Sep":
        no = 9;
        break;
      case "Oct":
        no = 10;
        break;
      case "Nov":
        no = 11;
        break;
      default:
        no = 12;
    }
    return no;
  }

  String findMonthName(var month) {
    String mon = "";
    switch (month) {
      case 1:
        mon = "Jan";
        break;
      case 2:
        mon = "Feb";
        break;
      case 3:
        mon = "Mar";
        break;
      case 4:
        mon = "Apr";
        break;
      case 5:
        mon = "May";
        break;
      case 6:
        mon = "Jun";
        break;
      case 7:
        mon = "Jul";
        break;
      case 8:
        mon = "Aug";
        break;
      case 9:
        mon = "Sep";
        break;
      case 10:
        mon = "Oct";
        break;
      case 11:
        mon = "Nov";
        break;
      default:
        mon = "Dec";
    }
    return mon;
  }

  bool findLeapYear(var year) {
    if (year % 400 == 0) return true;
    if (year % 100 == 0) return false;
    if (year % 4 == 0) return true;
    return false;
  }

  int getNoofDaysInMonth(var month, var year) {
    int days = 0;
    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        days = 31;
        break;
      case 4:
      case 6:
      case 8:
      case 10:
        days = 30;
        break;
      default:
        days = findLeapYear(year) ? 29 : 28;
    }
    return days;
  }
}
