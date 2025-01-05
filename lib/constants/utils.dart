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

String formatDateTime(String inputDateTime) {
  // Parse the input datetime string to a DateTime object
  DateTime dateTime = DateTime.parse(inputDateTime);

  // Format the DateTime object to the desired output format
  String formattedDate = DateFormat('MMM d, h:mm a').format(dateTime);

  return formattedDate;
}

String convertToFullDateTime(String inputDateTime) {
  // Parse the input datetime string
  DateTime dateTime = DateFormat('MMM d, h:mm a').parse(inputDateTime);

  // Format it to the desired output format
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').format(dateTime);

  return formattedDate;
}
