import 'package:attendance_appp/core/utils/routs.dart';
import 'package:attendance_appp/features/record_attendance/presentation/views/widgets/date_and_time_container.dart';
import 'package:attendance_appp/features/record_attendance/presentation/views/widgets/return_home_button.dart';
import 'package:attendance_appp/features/record_attendance/presentation/views/widgets/success_icon.dart';
import 'package:attendance_appp/features/record_attendance/presentation/views/widgets/success_message.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SuccessView extends StatelessWidget {
  // final String employeeName;
  // Remove timestamp parameter

  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current date and time automatically
    final now = DateTime.now();
    final date = "${now.day}/${now.month}/${now.year}";
    final time = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      //  backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.green,
          statusBarIconBrightness: Brightness.light,
        ),
        centerTitle: true,
        title: const Text(
          "Attendance Confirmation",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false, // Remove back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success icon
            SuccessIcon(),
            const SizedBox(height: 30),

            // Success message
            SuccessMessage(),
            const SizedBox(height: 20),

            // Employee name
            Text(
              "Welcome",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Date and time
            DateAndTimeContainer(date: date, time: time),
            const SizedBox(height: 40),

            // Return to map button
            ReturnHomeButton(),
          ],
        ),
      ),
    );
  }
}
