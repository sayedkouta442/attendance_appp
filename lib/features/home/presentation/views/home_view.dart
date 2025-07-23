import 'package:attendance_appp/features/home/presentation/views/widgets/attendance_this_month.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/month_attendance_count.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/request_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeef0f2),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xff3662e1),
              statusBarIconBrightness: Brightness.light,
            ),
            expandedHeight: 460,
            pinned: true,
            floating: false,
            snap: false,
            stretch: true,
            backgroundColor: Color(0xffeef0f2),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: CustomAppBar(),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AttendanceThisMonth(),
                  SizedBox(height: 24),
                  MonthAttendanceCount(),
                  SizedBox(height: 30),
                  RequestButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




















// class CustomAppBar extends StatelessWidget {
//   const CustomAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: 300,
//           width: MediaQuery.of(context).size.width,
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {},
//                         child: Container(
//                           height: 45,
//                           width: 45,
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(.4),
//                             borderRadius: BorderRadius.circular(36),
//                           ),
//                           child: Icon(Icons.location_on_outlined),
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Your Location'),
//                           SizedBox(height: 2),
//                           Text('Update location'),
//                         ],
//                       ),
//                       Spacer(),
//                       IconButton(
//                         onPressed: () {},
//                         icon: Icon(Icons.notifications),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30),
//                   Text(
//                     'Welcome, Sayed',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),

//         Positioned(
//           top: 240,
//           left: 18,
//           right: 18,
//           child: Container(
//             height: 200,
//             decoration: BoxDecoration(
//               color: Colors.green,
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }






/*

    Center(
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    textStyle: WidgetStatePropertyAll(
                      TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Check In'),
                ),
              ),


*/