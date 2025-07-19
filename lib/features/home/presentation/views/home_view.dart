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
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xff3662e1),
              statusBarIconBrightness: Brightness.light,
              // statusBarBrightness: Brightness.light,
            ),
            expandedHeight: 440,
            floating: true,
            pinned: true,
            backgroundColor: Color(0xffeef0f2),
            flexibleSpace: FlexibleSpaceBar(background: CustomAppBar()),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Attendance this month',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.date_range_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: AttendanceState()),
                      SizedBox(width: 8),
                      Expanded(child: AttendanceState()),
                      SizedBox(width: 8),
                      Expanded(child: AttendanceState()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AttendanceState extends StatelessWidget {
  const AttendanceState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(.1),
        border: Border(top: BorderSide(color: Colors.green, width: 5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Present',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Row(
              children: [
                Spacer(),
                Text(
                  '20',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 255,
          width: MediaQuery.of(context).size.width,
          color: Color(0xff3662e1),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.4),
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Icon(Icons.location_on_outlined),
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Location'),
                        SizedBox(height: 2),
                        Text('Update location'),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Welcome, Sayed',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: Container(
            //    height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.only(top: 175, left: 18, right: 18),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xff3662e1),
                      ),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      textStyle: WidgetStatePropertyAll(
                        TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Check In'),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                    thickness: 1,
                    endIndent: 20,
                    indent: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: CheckTime()),
                        SizedBox(width: 24),
                        Expanded(child: CheckTime()),
                        SizedBox(width: 24),
                        Expanded(child: CheckTime()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //  height: 500,
          ),
        ),
      ],
    );
  }
}

class CheckTime extends StatelessWidget {
  const CheckTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.access_time, color: Color(0xff3662e1)),
        SizedBox(height: 8),
        Text(
          '10:00 AM',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Check In',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
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