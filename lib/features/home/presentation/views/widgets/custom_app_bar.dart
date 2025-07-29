import 'package:attendance_appp/features/home/presentation/views/widgets/attendance_check_positioned_container.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/location_icon.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/notificationIcon.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/user_location.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/user_welcome.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 270,
          width: MediaQuery.of(context).size.width,
          color: Color(0xff3662e1),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    LocationIcon(),
                    SizedBox(width: 8),
                    Expanded(flex: 4, child: UserLocation()),
                    Spacer(),
                    NotificationIcon(),
                  ],
                ),
                SizedBox(height: 40),
                UserWelcome(),
              ],
            ),
          ),
        ),
        AttendanceCheckPositionedContainer(),
      ],
    );
  }
}
