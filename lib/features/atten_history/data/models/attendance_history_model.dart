import 'package:flutter/material.dart'; // For TimeOfDay

class AttendanceRecord {
  final String employeeId;
  final DateTime recordDate;
  final TimeOfDay? checkInTime;
  final TimeOfDay? checkOutTime;
  final String status;
  final Duration? workingHours; // Represents INTERVAL type from PostgreSQL

  AttendanceRecord({
    required this.employeeId,
    required this.recordDate,
    this.checkInTime,
    this.checkOutTime,
    required this.status,
    this.workingHours,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    TimeOfDay? parseTimeOfDay(String? timeString) {
      if (timeString == null) return null;
      final parts = timeString.split(':');
      if (parts.length >= 2) {
        return TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
      return null;
    }

    Duration? parseDuration(String? durationString) {
      if (durationString == null) return null;
      try {
        final parts = durationString.split(":");
        if (parts.length == 3) {
          final hours = int.parse(parts[0]);
          final minutes = int.parse(parts[1]);
          final seconds = int.parse(parts[2]);
          return Duration(hours: hours, minutes: minutes, seconds: seconds);
        } else if (parts.length == 2) {
          final minutes = int.parse(parts[0]);
          final seconds = int.parse(parts[1]);
          return Duration(minutes: minutes, seconds: seconds);
        }
      } catch (e) {
        print("Error parsing duration string: $durationString - $e");
      }
      return null;
    }

    return AttendanceRecord(
      employeeId: json["employee_id"] as String,
      recordDate: DateTime.parse(json["record_date"] as String),
      checkInTime: parseTimeOfDay(json["check_in_time"] as String?),
      checkOutTime: parseTimeOfDay(json["check_out_time"] as String?),
      status: json["status"] as String,
      workingHours: parseDuration(json["working_hours"] as String?),
    );
  }

  // Helper method to format TimeOfDay to 12-hour format with AM/PM
  String formatTimeOfDay(TimeOfDay? time) {
    if (time == null) return "--";

    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  // Getter for formatted check-in time
  String get formattedCheckInTime => formatTimeOfDay(checkInTime);

  // Getter for formatted check-out time
  String get formattedCheckOutTime => formatTimeOfDay(checkOutTime);

  // Helper method to format working hours as HH:MM
  String get formattedWorkingHours {
    if (workingHours == null) return "--";

    final hours = workingHours!.inHours;
    final minutes = workingHours!.inMinutes.remainder(60);

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  @override
  String toString() {
    return 'AttendanceRecord(employeeId: $employeeId, recordDate: $recordDate, checkInTime: $formattedCheckInTime, checkOutTime: $formattedCheckOutTime, status: $status, workingHours: $formattedWorkingHours)';
  }
}
