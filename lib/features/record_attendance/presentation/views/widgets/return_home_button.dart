import 'package:attendance_appp/core/utils/routs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReturnHomeButton extends StatelessWidget {
  const ReturnHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        GoRouter.of(context).go(AppRouter.kHomeView); // Return to map screen
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        "Return to Home",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
