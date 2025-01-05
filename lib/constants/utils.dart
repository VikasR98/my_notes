import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

verticalSpace(double value){
  return SizedBox(height: value,);
}

horizontalSpace(double value){
  return SizedBox(width: value,);
}

String formatDate(String dateTimeString) {
  // Parse the input DateTime string
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Format the date using Intl package
  String daySuffix = getDaySuffix(dateTime.day);
  String formattedDate = DateFormat("MMM yyyy").format(dateTime);

  return "${dateTime.day}$daySuffix $formattedDate";
}
String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return "th"; // Special case for 11th, 12th, 13th
  }
  switch (day % 10) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}
