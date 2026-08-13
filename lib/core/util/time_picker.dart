import 'package:flutter/material.dart';

Future<TimeOfDay?> timePicker(
  BuildContext context, {
  TimeOfDay? initialTime,
}) async {
  return showTimePicker(
    context: context,
    initialTime: initialTime ?? TimeOfDay.now(),
  );
}
