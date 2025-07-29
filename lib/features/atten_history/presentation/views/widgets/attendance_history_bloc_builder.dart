import 'package:attendance_appp/features/atten_history/presentation/view_model/cubit/attendance_history_cubit.dart';
import 'package:attendance_appp/features/atten_history/presentation/views/widgets/attendacne_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceHistoryBlocBuilder extends StatelessWidget {
  const AttendanceHistoryBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceHistoryCubit, AttendanceHistoryState>(
      builder: (context, state) {
        if (state is AttendanceHistoryLoading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is AttendanceHistorySuccess) {
          if (state.attendance.isEmpty) {
            return const SliverFillRemaining(
              child: Center(
                child: Text('No attendance records found for this month.'),
              ),
            );
          }
          // 2. استخدام الويدجت الجديد هنا
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final record = state.attendance[index];
              return AttendanceListItem(record: record);
            }, childCount: state.attendance.length),
          );
        } else if (state is AttendanceHistoryFailure) {
          return SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Failed to load data: ${state.errMessage}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else {
          return const SliverFillRemaining(
            child: Center(child: Text('Select a month to view history.')),
          );
        }
      },
    );
  }
}
