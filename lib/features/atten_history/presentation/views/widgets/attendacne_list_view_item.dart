import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:attendance_appp/features/atten_history/data/models/attendance_history_model.dart';

class AttendanceListItem extends StatelessWidget {
  final AttendanceRecord record;

  const AttendanceListItem({super.key, required this.record});

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'No Date';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('EEE, MMM d, yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String _formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return '--:--';
    if (timeStr.startsWith('TimeOfDay(')) {
      final timeValue = timeStr.substring(10, timeStr.length - 1);
      final parts = timeValue.split(':');
      if (parts.length == 2) {
        try {
          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);
          final tempDate = DateTime(2025, 1, 1, hour, minute);
          return DateFormat('h:mm a').format(tempDate);
        } catch (e) {
          return '--:--';
        }
      }
    }
    try {
      final time = DateFormat('HH:mm:ss').parse(timeStr);
      return DateFormat('h:mm a').format(time);
    } catch (e) {
      return timeStr;
    }
  }

  String _formatWorkingHours(String? durationString) {
    if (durationString == null || durationString.isEmpty) {
      return '0:00';
    }
    final parts = durationString.split('.');
    return parts[0];
  }

  Widget _buildTimeDetail({
    required String label,
    required String time,
    required Color color,
    CrossAxisAlignment? alignment,
  }) {
    return Column(
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAbsent = record.checkInTime == null;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black.withOpacity(.5) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: isAbsent ? Colors.red.shade700 : Colors.blue.shade700,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 16),

            if (isAbsent)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDate(record.recordDate.toString()),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    // كلمة "Absent" على اليمين باللون الأحمر
                    const Text(
                      'Absent',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDate(record.recordDate.toString()),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTimeDetail(
                            label: 'Check In',
                            time: _formatTime(record.checkInTime.toString()),
                            color: (record.status.toLowerCase() == 'late')
                                ? Colors.red.shade600
                                : Colors.green.shade600,
                          ),
                        ),
                        Expanded(
                          child: _buildTimeDetail(
                            label: 'Check Out',
                            time: _formatTime(record.checkOutTime.toString()),
                            color: Colors.orange.shade700,
                          ),
                        ),
                        Expanded(
                          child: _buildTimeDetail(
                            label: 'Working HR\'s',
                            time: _formatWorkingHours(
                              record.workingHours.toString(),
                            ),
                            color: Colors.green.shade600,
                            alignment: CrossAxisAlignment.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
    // --- نهاية التعديل الرئيسي ---
  }
}
