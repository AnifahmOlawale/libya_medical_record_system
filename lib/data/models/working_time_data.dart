import 'package:flutter/material.dart';

class WorkingTime {
  const WorkingTime({this.startTime, this.endTime, this.isActive = false});

  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final bool isActive;

  WorkingTime copyWith({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? isActive,
  }) {
    return WorkingTime(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isActive: isActive ?? this.isActive,
    );
  }

  bool get isValid {
    if (!isActive) return true;
    if (startTime == null || endTime == null) return false;

    final startMinutes = startTime!.hour * 60 + startTime!.minute;
    final endMinutes = endTime!.hour * 60 + endTime!.minute;
    return endMinutes > startMinutes;
  }

  String? get validationError {
    if (!isActive) return null;
    if (startTime == null) return 'Start time is required';
    if (endTime == null) return 'End time is required';

    final startMinutes = startTime!.hour * 60 + startTime!.minute;
    final endMinutes = endTime!.hour * 60 + endTime!.minute;

    if (endMinutes <= startMinutes) {
      return 'End time must be after start time';
    }
    return null;
  }
}

class WeeklySchedule {
  const WeeklySchedule({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  final WorkingTime monday;
  final WorkingTime tuesday;
  final WorkingTime wednesday;
  final WorkingTime thursday;
  final WorkingTime friday;
  final WorkingTime saturday;
  final WorkingTime sunday;

  WeeklySchedule copyWith({
    WorkingTime? monday,
    WorkingTime? tuesday,
    WorkingTime? wednesday,
    WorkingTime? thursday,
    WorkingTime? friday,
    WorkingTime? saturday,
    WorkingTime? sunday,
  }) {
    return WeeklySchedule(
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
    );
  }

  List<WorkingTime> get allDays => [
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,
  ];

  bool get hasAnyActiveDay {
    return allDays.any((day) => day.isActive);
  }

  bool get isValid {
    return allDays.every((day) => day.isValid);
  }
}
