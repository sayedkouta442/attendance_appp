import 'package:attendance_appp/core/common/page_title.dart';
import 'package:attendance_appp/features/atten_history/presentation/views/widgets/attendance_history_bloc_builder.dart';

import 'package:attendance_appp/features/home/presentation/views/widgets/attendance_this_month.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class AttendanceHistoryView extends StatelessWidget {
  const AttendanceHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.grey.shade50, // لون خلفية مشابه للتصميم
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //    backgroundColor: Colors.grey.shade50,
            // systemOverlayStyle: SystemUiOverlayStyle(
            //   statusBarBrightness: Brightness.light,
            //   statusBarColor: ,
            // ),
            surfaceTintColor: Colors.grey.shade50,
            expandedHeight: 160,
            pinned: true,
            title: PageTitle(title: "Attendance History"),
            leading: IconButton(
              onPressed: () {
                StatefulNavigationShell.of(context).goBranch(0);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
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
          AttendanceHistoryBlocBuilder(),
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
