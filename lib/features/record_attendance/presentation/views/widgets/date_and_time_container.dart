import 'package:flutter/material.dart';

class DateAndTimeContainer extends StatelessWidget {
  const DateAndTimeContainer({
    super.key,
    required this.date,
    required this.time,
  });

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        //   color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                "Date: $date",
                style: const TextStyle(
                  fontSize: 16,
                  //  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                "Time: $time",
                style: const TextStyle(
                  fontSize: 16,
                  //  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
