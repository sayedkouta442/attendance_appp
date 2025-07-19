import 'package:flutter/material.dart';

class AttendanceThisMonth extends StatelessWidget {
  const AttendanceThisMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Attendance this month',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.date_range_outlined, color: Colors.grey),
        ),
      ],
    );
  }
}
