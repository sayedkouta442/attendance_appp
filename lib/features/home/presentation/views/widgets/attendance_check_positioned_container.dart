import 'package:attendance_appp/core/utils/routs.dart';
import 'package:attendance_appp/features/home/presentation/views/widgets/check_time.dart';
import 'package:attendance_appp/features/record_attendance/data/models/attendance_time_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class CheckInOutButton extends StatefulWidget {
  const CheckInOutButton({super.key});

  @override
  State<CheckInOutButton> createState() => _CheckInOutButtonState();
}

class _CheckInOutButtonState extends State<CheckInOutButton> {
  @override
  void initState() {
    // _deleteBox();
    super.initState();
  }

  void _deleteBox() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('checkedIn');
  }

  Future<bool> _getCheckInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('checkedIn') ?? false;
  }

  void _handleButtonLogic(BuildContext context) {
    final now = DateTime.now();
    final timeService = AttendanceTimeService();
    final status = timeService.checkInStatus(now);

    if (status == "Too Early") {
      _showMessage(context, "⏰ It's too early to check in.");
      return;
    }

    if (status == "Too Late") {
      _showMessage(
        context,
        "🚫 You are too late to check in. Marked as absent.",
      );
      return;
    }

    if (status == "Weekend - No attendance required") {
      _showMessage(context, "🎉 No work today!");
      return;
    }

    GoRouter.of(context).push(AppRouter.kLocationView);
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _getCheckInStatus(),
      builder: (context, snapshot) {
        final isChecked = snapshot.data ?? false;

        return ElevatedButton(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            ),
            backgroundColor: WidgetStatePropertyAll(
              Color(isChecked ? 0xffe13636 : 0xff3662e1),
            ),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          onPressed: () => _handleButtonLogic(context),
          child: Text(isChecked ? 'Check Out' : 'Check In'),
        );
      },
    );
  }
}
