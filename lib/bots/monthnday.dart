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
    print(month);
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
