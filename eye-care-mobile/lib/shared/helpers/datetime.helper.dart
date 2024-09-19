import 'package:flutter/material.dart';

String formatDate(DateTime date) {
  return "${date.month}/${date.day}/${date.year}";
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final hours = (timeOfDay.hourOfPeriod % 12).toString();
  final minutes = timeOfDay.minute.toString().padLeft(2, '0');
  final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hours:$minutes $period';
}
