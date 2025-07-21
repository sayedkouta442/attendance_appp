import 'package:flutter/material.dart';

class AttendanceHistory extends StatelessWidget {
  const AttendanceHistory({super.key});

  final List<Map<String, String>> attendanceData = const [
    {
      'date': '2025-07-14',
      'checkIn': '08:45 AM',
      'checkOut': '05:00 PM',
      'status': 'Present',
    },
    {
      'date': '2025-07-13',
      'checkIn': '09:15 AM',
      'checkOut': '05:10 PM',
      'status': 'Late',
    },
    {
      'date': '2025-07-12',
      'checkIn': '--',
      'checkOut': '--',
      'status': 'Absent',
    },
    {
      'date': '2025-07-11',
      'checkIn': '08:30 AM',
      'checkOut': '04:50 PM',
      'status': 'Present',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'Present':
        return Colors.green;
      case 'Late':
        return Colors.orange;
      case 'Absent':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: attendanceData.length,
        itemBuilder: (context, index) {
          final data = attendanceData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(
                Icons.calendar_today,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('Date: ${data['date']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Check-in: ${data['checkIn']}'),
                  Text('Check-out: ${data['checkOut']}'),
                ],
              ),
              trailing: Text(
                data['status']!,
                style: TextStyle(
                  color: _statusColor(data['status']!),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
