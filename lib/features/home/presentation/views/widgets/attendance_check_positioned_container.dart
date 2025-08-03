import 'package:attendance_appp/features/home/presentation/views/widgets/check_in_out_button.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/check_time.dart';

import 'package:flutter/material.dart';

class AttendanceCheckPositionedContainer extends StatelessWidget {
  const AttendanceCheckPositionedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Positioned(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black.withOpacity(.5) : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.only(top: 220, left: 18, right: 18),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CheckInOutButton(),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 1,
                endIndent: 20,
                indent: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CheckTime(
                        time: '10:00 AM',
                        type: 'Check In',
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: CheckTime(
                        time: '06:00 BM',
                        type: 'Check Out',
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: CheckTime(
                        time: '08:00:00',
                        type: 'working Hour\'s',
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //  height: 500,
      ),
    );
  }
}
