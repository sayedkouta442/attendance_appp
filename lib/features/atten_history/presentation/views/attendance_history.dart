import 'package:attendance_appp/core/utils/pop_arrow.dart';

import 'package:attendance_appp/features/atten_history/presentation/view_model/cubit/attendance_history_cubit.dart';
import 'package:attendance_appp/features/atten_history/presentation/views/widgets/attendacne_list_view_item.dart';

import 'package:attendance_appp/features/home/presentation/views/widgets/attendance_this_month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceHistoryView extends StatelessWidget {
  const AttendanceHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, // لون خلفية مشابه للتصميم
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.grey.shade50,
            surfaceTintColor: Colors.grey.shade50,
            expandedHeight: 160,
            pinned: true,
            title: const Text('Attendance History'),
            leading: const PopArrow(),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 80, 16, 24),
                  child: Column(children: const [AttendanceThisMonth()]),
                ),
              ),
            ),
          ),
          BlocBuilder<AttendanceHistoryCubit, AttendanceHistoryState>(
            builder: (context, state) {
              if (state is AttendanceHistoryLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is AttendanceHistorySuccess) {
                if (state.attendance.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No attendance records found for this month.',
                      ),
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
          ),
        ],
      ),
    );
  }
}






















// class AttendanceHistory extends StatelessWidget {
//   const AttendanceHistory({super.key});

//   final List<Map<String, String>> attendanceData = const [
//     {
//       'date': '2025-07-14',
//       'checkIn': '08:45 AM',
//       'checkOut': '05:00 PM',
//       'status': 'Present',
//     },
//     {
//       'date': '2025-07-13',
//       'checkIn': '09:15 AM',
//       'checkOut': '05:10 PM',
//       'status': 'Late',
//     },
//     {
//       'date': '2025-07-12',
//       'checkIn': '--',
//       'checkOut': '--',
//       'status': 'Absent',
//     },
//     {
//       'date': '2025-07-11',
//       'checkIn': '08:30 AM',
//       'checkOut': '04:50 PM',
//       'status': 'Present',
//     },
//   ];

//   Color _statusColor(String status) {
//     switch (status) {
//       case 'Present':
//         return Colors.green;
//       case 'Late':
//         return Colors.orange;
//       case 'Absent':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

      
//       appBar: AppBar(
//         leading: PopArrow(),
//         title: const Text('Attendance History'),
//         centerTitle: true,
//         actions: [
//           IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt_outlined)),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: attendanceData.length,
//         itemBuilder: (context, index) {
//           final data = attendanceData[index];
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: ListTile(
//               // leading: Icon(
//               //   Icons.calendar_today,
//               //   color: Theme.of(context).primaryColor,
//               // ),
//               title: Row(
//                 children: [
//                   Icon(
//                     Icons.calendar_today,
//                     size: 16,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   SizedBox(width: 4),
//                   Text(
//                     '${data['date']}',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,

//                 children: [
//                   const SizedBox(height: 8),
//                   Text.rich(
//                     TextSpan(
//                       style: TextStyle(fontSize: 16),
//                       text: 'Check-in: ',
//                       children: [
//                         TextSpan(
//                           text: '  ${data['checkIn']}',
//                           children: [],
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),

//                     // style: TextStyle(fontSize: 16),
//                   ),
//                   Text.rich(
//                     TextSpan(
//                       style: TextStyle(fontSize: 16),
//                       text: 'Check-out: ',
//                       children: [
//                         TextSpan(
//                           text: '${data['checkOut']}',
//                           children: [],
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),

//                     // style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//               trailing: Text(
//                 data['status']!,
//                 style: TextStyle(
//                   color: _statusColor(data['status']!),
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
