import 'package:attendance_appp/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class AttendanceThisMonth extends StatefulWidget {
  const AttendanceThisMonth({super.key});

  @override
  State<AttendanceThisMonth> createState() => _AttendanceThisMonthState();
}

class _AttendanceThisMonthState extends State<AttendanceThisMonth> {
  late int selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedMonth = DateTime.now().month;
  }

  void _selectMonth(BuildContext context) async {
    final selected = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      setState(() {
        selectedMonth = selected.month;
      });
      print("Selected month: ${selected.month}/${selected.year}");
    }
  }

  String getMonthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Attendance this month', style: TextStyle(fontSize: 20)),
        InkWell(
          onTap: () => _selectMonth(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: primaryColor, width: 2),
            ),
            child: Row(
              children: [
                Text(
                  getMonthName(selectedMonth),
                  style: const TextStyle(fontSize: 16, color: primaryColor),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.date_range_outlined,
                  color: primaryColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
