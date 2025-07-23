class AttendanceTimeService {
  final int checkInStartHour = 6;
  final int checkInStartMinute = 0;
  final int checkInEndHour = 10;
  final int checkInEndMinute = 30;

  final int checkOutHour = 17; // 5:00 PM

  /// Returns whether today is a working day (not Friday or Saturday)
  bool isWorkingDay(DateTime now) {
    return now.weekday != DateTime.friday && now.weekday != DateTime.saturday;
  }

  /// Returns whether it's within check-in window
  bool isWithinCheckInWindow(DateTime now) {
    final start = DateTime(
      now.year,
      now.month,
      now.day,
      checkInStartHour,
      checkInStartMinute,
    );
    final end = DateTime(
      now.year,
      now.month,
      now.day,
      checkInEndHour,
      checkInEndMinute,
    );
    return now.isAfter(start) && now.isBefore(end);
  }

  /// Returns whether it's late (after check-in window but before cutoff)
  bool isLate(DateTime now) {
    final end = DateTime(
      now.year,
      now.month,
      now.day,
      checkInEndHour,
      checkInEndMinute,
    );
    final cutoff = DateTime(now.year, now.month, now.day, 12, 0); // 12:00 PM
    return now.isAfter(end) && now.isBefore(cutoff);
  }

  /// Returns whether the user is too late and cannot check in
  bool isTooLateToCheckIn(DateTime now) {
    final cutoff = DateTime(
      now.year,
      now.month,
      now.day,
      12,
      0,
    ); // After 12:00 PM
    return now.isAfter(cutoff);
  }

  /// Returns whether it's time to check out
  bool isCheckOutTime(DateTime now) {
    final checkout = DateTime(now.year, now.month, now.day, checkOutHour);
    return now.isAfter(checkout);
  }

  /// Human-readable decision
  String checkInStatus(DateTime now) {
    if (!isWorkingDay(now)) return "Weekend - No attendance required";
    if (isWithinCheckInWindow(now)) return "Present";
    if (isLate(now)) return "Late";
    if (isTooLateToCheckIn(now)) return "Absent - Too late to check in";
    return "Too Early";
  }
}
