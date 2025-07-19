import 'package:attendance_appp/features/home/presentation/views/home_view.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/take_attendance_state.dart';
import 'package:flutter/material.dart';

class MonthAttendanceCount extends StatelessWidget {
  const MonthAttendanceCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TakeAttendanceState(
            color: Colors.green,
            attendanceType: 'Present',
            typeCount: 20,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: TakeAttendanceState(
            color: Colors.red,
            attendanceType: 'Absents',
            typeCount: 2,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: TakeAttendanceState(
            color: Colors.orange,
            attendanceType: 'Late',
            typeCount: 4,
          ),
        ),
      ],
    );
  }
}
