// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:libya_school_management/l10n/app_localizations.dart';

// class DateFormatter {
//   /// Format: "24 Jan, 2025 at 20:25PM"
//   static String dateformat1(DateTime dateTime) {
//     final date = DateFormat("dd MMM, yyyy").format(dateTime);
//     final time = DateFormat("HH:mm a").format(dateTime);
//     return "$date at $time";
//   }

//   /// Format: "Friday 24 Jan, 2025 at 20:25PM"
//   static String dateformat2(DateTime dateTime) {
//     final date = DateFormat("EEEE dd MMM, yyyy").format(dateTime);
//     final time = DateFormat("HH:mm a").format(dateTime);
//     return "$date at $time";
//   }

//   /// Format: "24 Jan, 2025"
//   static String dateformat3(DateTime dateTime) {
//     final date = DateFormat("dd MMM, yyyy").format(dateTime);
//     return date;
//   }

//   /// Format: "24 Jan, 2025 : 17:15PM"
//   static String dateformat4(DateTime dateTime) {
//     final date = DateFormat("dd MMM, yyyy : HH:mm a").format(dateTime);
//     return date;
//   }

//   /// Format: "Friday 24 Jan, 2025"
//   static String dateformat5(DateTime dateTime) {
//     final date = DateFormat("EEEE dd MMM, yyyy").format(dateTime);
//     return date;
//   }

//   /// Format:
//   /// Today, 17:20
//   /// Yesterday, 09:12
//   /// 3 days ago, 14:30
//   /// 22 Jan, 2025 : 17:20
//   static String smartDate(DateTime dateTime) {
//     final now = DateTime.now();
//     final difference = now.difference(dateTime);

//     final time = DateFormat("HH:mm").format(dateTime);

//     // Today
//     if (_isSameDay(now, dateTime)) {
//       return "Today, $time";
//     }

//     // Yesterday
//     final yesterday = now.subtract(const Duration(days: 1));

//     if (_isSameDay(yesterday, dateTime)) {
//       return "Yesterday, $time";
//     }

//     // Within 7 days
//     if (difference.inDays < 7) {
//       return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago, $time";
//     }

//     // Older dates
//     return DateFormat("dd MMM, yyyy : HH:mm").format(dateTime);
//   }

//   /// Format: "Good Morning / Afternoon / Evening"
//   static String getGreetingMessage(BuildContext context) {
//     final hour = DateTime.now().hour;
//     final local = AppLocalizations.of(context);

//     if (hour >= 5 && hour < 12) {
//       return local.greetingMorning;
//     } else if (hour >= 12 && hour < 17) {
//       return local.greetingAfternoon;
//     } else {
//       return local.greetingEvening;
//     }
//   }

//   static bool _isSameDay(DateTime a, DateTime b) {
//     return a.year == b.year && a.month == b.month && a.day == b.day;
//   }
// }
