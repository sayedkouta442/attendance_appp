import 'package:attendance_appp/features/atten_history/presentation/view_model/cubit/attendance_history_cubit.dart';
import 'package:attendance_appp/features/home/presentation/views/home_view.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/take_attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonthAttendanceCount extends StatelessWidget {
  const MonthAttendanceCount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceHistoryCubit, AttendanceHistoryState>(
      builder: (context, state) {
        if (state is AttendanceHistorySuccess) {
          int present = 0;
          int absent = 0;
          int late = 0;

          for (var record in state.attendance) {
            final status = record.status;
            if (status == 'Present') {
              present++;
            } else if (status == 'Absent') {
              absent++;
            } else {
              late++;
            }
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TakeAttendanceState(
                  color: Colors.green,
                  attendanceType: 'Present',
                  typeCount: present,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TakeAttendanceState(
                  color: Colors.red,
                  attendanceType: 'Absents',
                  typeCount: absent,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TakeAttendanceState(
                  color: Colors.orange,
                  attendanceType: 'Late',
                  typeCount: late,
                ),
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
