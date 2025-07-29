class LeaveModel {
  final String? employeeId;
  final String leaveType;
  final DateTime fromDate;
  final DateTime toDate;
  final String? reason;
  final String? status;
  final DateTime? requestDate;
  LeaveModel({
    this.requestDate,
    this.status,
    this.employeeId,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'start_date': fromDate.toIso8601String(),
      'end_date': toDate.toIso8601String(),
      'leave_type': leaveType,
      'reason': reason,
    };
  }

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      status: json['status'],

      leaveType: json['leave_type'],
      fromDate: DateTime.parse(json["start_date"]),
      toDate: DateTime.parse(json["end_date"]),
      reason: json["reason"],
      requestDate: DateTime.parse(json['request_date']),
    );
  }
}
