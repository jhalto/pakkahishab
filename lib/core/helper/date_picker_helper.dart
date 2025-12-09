import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String?> pickDate({
  required BuildContext context,
  String dateFormat = 'yyyy-MM-dd', // Default format
}) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );

  if (picked == null) return null;

  return DateFormat(dateFormat).format(picked);
}
