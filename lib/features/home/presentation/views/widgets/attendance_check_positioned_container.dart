import 'package:attendance_appp/core/utils/routs.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/check_time.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AttendanceCheckPositionedContainer extends StatelessWidget {
  const AttendanceCheckPositionedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
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
                  horizontal: 24,
                  vertical: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CheckTime(time: '10:00 AM', type: 'Check In'),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: CheckTime(time: '06:00 BM', type: 'Check Out'),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: CheckTime(
                        time: '08:00:00',
                        type: 'working Hour\'s',
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

class CheckInOutButton extends StatelessWidget {
  const CheckInOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        ),
        backgroundColor: WidgetStatePropertyAll(Color(0xff3662e1)),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: () {
        GoRouter.of(context).push(AppRouter.kLocationView);
      },
      child: const Text('Check In'),
    );
  }
}
