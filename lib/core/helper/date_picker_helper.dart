import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/const/app_colors.dart';

Future<String?> pickDate({
  required BuildContext context,
  String dateFormat = 'yyyy-MM-dd',
}) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryColor,        // Header & selected date
            onPrimary: Colors.white,      // Header text
            onSurface: Colors.black,      // Body text
          ),
          scaffoldBackgroundColor: Colors.white, // Background
        ),
        child: child!,
      );
    },
  );

  if (picked == null) return null;

  return DateFormat(dateFormat).format(picked);
}
String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatApiDate(String rawDate) {
  final dateTime = DateTime.parse(rawDate).toLocal();
  return DateFormat('yyyy-MM-dd').format(dateTime);
}