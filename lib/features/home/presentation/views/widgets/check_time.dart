import 'package:flutter/material.dart';

class CheckTime extends StatelessWidget {
  const CheckTime({super.key, required this.time, required this.type});
  final String time;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.access_time, color: Color(0xff3662e1)),
        SizedBox(height: 8),
        Text(
          time, //  '10:00 AM',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          type, // 'Check In',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
