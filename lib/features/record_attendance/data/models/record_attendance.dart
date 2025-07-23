import 'package:intl/intl.dart';

class AttendanceRecordModel {
  final String? id;
  final String employeeId;
  final DateTime? recordDate;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final AttendanceStatus? status;
  final double? checkInLocationLat;
  final double? checkInLocationLon;
  final double? checkOutLocationLat;
  final double? checkOutLocationLon;
  final Duration? workingHours;

  AttendanceRecordModel({
    this.id,
    required this.employeeId,
    this.recordDate,
    this.checkInTime,
    this.checkOutTime,
    this.status,
    this.checkInLocationLat,
    this.checkInLocationLon,
    this.checkOutLocationLat,
    this.checkOutLocationLon,
    this.workingHours,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      id: json["id"] as String?,
      employeeId: json["employee_id"] as String,
      recordDate: json["record_date"] != null
          ? DateTime.parse(json["record_date"])
          : null,
      checkInTime: json["check_in_time"] != null
          ? _parseTimeOnly(json["check_in_time"])
          : null,
      checkOutTime: json["check_out_time"] != null
          ? _parseTimeOnly(json["check_out_time"])
          : null,
      status: AttendanceStatus.fromString(json["status"] as String),
      checkInLocationLat: (json["check_in_location_lat"] as num?)?.toDouble(),
      checkInLocationLon: (json["check_in_location_lon"] as num?)?.toDouble(),
      checkOutLocationLat: (json["check_out_location_lat"] as num?)?.toDouble(),
      checkOutLocationLon: (json["check_out_location_lon"] as num?)?.toDouble(),
      workingHours: json["working_hours"] != null
          ? _parseDuration(json["working_hours"] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "employee_id": employeeId,
      "record_date": recordDate?.toIso8601String().split('T')[0],
      "check_in_time": _formatTimeOnly(checkInTime),
      "check_out_time": _formatTimeOnly(checkOutTime),
      "status": status!.value,
      "check_in_location_lat": checkInLocationLat,
      "check_in_location_lon": checkInLocationLon,
      "check_out_location_lat": checkOutLocationLat,
      "check_out_location_lon": checkOutLocationLon,
      "working_hours": workingHours?.toString(),
    };
  }

  Map<String, dynamic> toInsertJson() {
    return {
      "employee_id": employeeId,
      "record_date": recordDate?.toIso8601String().split('T')[0],
      "check_in_time": _formatTimeOnly(checkInTime),
      "status": status!.value,
      "check_in_location_lat": checkInLocationLat,
      "check_in_location_lon": checkInLocationLon,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> data = {};

    if (checkOutTime != null) {
      data["check_out_time"] = _formatTimeOnly(checkOutTime);
    }
    if (checkOutLocationLat != null) {
      data["check_out_location_lat"] = checkOutLocationLat;
    }
    if (checkOutLocationLon != null) {
      data["check_out_location_lon"] = checkOutLocationLon;
    }
    if (workingHours != null) {
      data["working_hours"] = workingHours.toString();
    }
    if (status != null) {
      data["status"] = status!.value;
    }

    return data;
  }

  AttendanceRecordModel copyWith({
    String? id,
    String? employeeId,
    DateTime? recordDate,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    AttendanceStatus? status,
    double? checkInLocationLat,
    double? checkInLocationLon,
    double? checkOutLocationLat,
    double? checkOutLocationLon,
    Duration? workingHours,
  }) {
    return AttendanceRecordModel(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      recordDate: recordDate ?? this.recordDate,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      status: status ?? this.status,
      checkInLocationLat: checkInLocationLat ?? this.checkInLocationLat,
      checkInLocationLon: checkInLocationLon ?? this.checkInLocationLon,
      checkOutLocationLat: checkOutLocationLat ?? this.checkOutLocationLat,
      checkOutLocationLon: checkOutLocationLon ?? this.checkOutLocationLon,
      workingHours: workingHours ?? this.workingHours,
    );
  }

  Duration? calculateWorkingHours() {
    if (checkInTime != null && checkOutTime != null) {
      return checkOutTime!.difference(checkInTime!);
    }
    return null;
  }

  bool get isComplete => checkInTime != null && checkOutTime != null;
  bool get isCurrentlyAtWork => checkInTime != null && checkOutTime == null;

  static Duration? _parseDuration(String durationString) {
    try {
      final parts = durationString.split(":");
      if (parts.length == 3) {
        return Duration(
          hours: int.parse(parts[0]),
          minutes: int.parse(parts[1]),
          seconds: int.parse(parts[2]),
        );
      }
    } catch (e) {
      print("Error parsing duration: $e");
    }
    return null;
  }

  static DateTime _parseTimeOnly(String time) {
    final now = DateTime.now();
    final parts = time.split(":");
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2].split(".")[0]),
    );
  }

  static String? _formatTimeOnly(DateTime? dateTime) {
    if (dateTime == null) return null;
    return DateFormat.Hms().format(dateTime); // HH:mm:ss
  }

  @override
  String toString() {
    return "AttendanceRecord(id: $id, employeeId: $employeeId, recordDate: $recordDate, status: $status)";
  }

  @override
  bool operator ==(Object other) {
    return other is AttendanceRecordModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

enum AttendanceStatus {
  present("Present"),
  late("Late"),
  absent("Absent");

  const AttendanceStatus(this.value);
  final String value;

  static AttendanceStatus fromString(String value) {
    switch (value) {
      case "Present":
        return AttendanceStatus.present;
      case "Late":
        return AttendanceStatus.late;
      case "Absent":
        return AttendanceStatus.absent;
      default:
        throw ArgumentError("Unknown attendance status: $value");
    }
  }

  @override
  String toString() => value;
}
