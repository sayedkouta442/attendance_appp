import 'package:flutter/material.dart';

class SuccessMessage extends StatelessWidget {
  const SuccessMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Attendance Recorded Successfully!",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.green.shade800,
      ),
      textAlign: TextAlign.center,
    );
  }
}
