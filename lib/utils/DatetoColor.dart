import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DatetoColor {

  static var colorMap= {
    "Monday":Colors.blue,
    "Tuesday": Colors.black,
    "Wednesday" : Colors.white,
    "Thursday" :Colors.green,
    "Friday" : Colors.red,
    "Saturday" : Colors.pink,
    "Sunday" : Colors.yellow
  };
  static String covertDatetimetoString(DateTime date)
  {
    String dateStr=DateFormat('yyyy-MM-dd').format(date);
    return dateStr;
  }
  static Color getColors(DateTime date){
    String weekday=DateFormat('EEEE').format(date);
    Color color = colorMap.containsKey(weekday)?colorMap[weekday]:Colors.grey;
    if(date.isAfter(DateTime.now()))
      color = Colors.grey;
    return color;
  }
}