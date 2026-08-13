import 'package:flutter/material.dart';

Future<DateTime?> datePicker(
  BuildContext context, {
  required DateTime? initialDate,
  required DateTime firstDate,
  DateTime? lastDate,
}) async {
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate ?? DateTime(2100),
  );
}
