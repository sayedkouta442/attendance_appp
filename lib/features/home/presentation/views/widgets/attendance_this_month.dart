import 'package:attendance_appp/features/atten_history/presentation/view_model/cubit/attendance_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:attendance_appp/core/utils/constants.dart'; // تأكد من أن هذا المسار صحيح

class AttendanceThisMonth extends StatefulWidget {
  const AttendanceThisMonth({super.key});

  @override
  State<AttendanceThisMonth> createState() => _AttendanceThisMonthState();
}

class _AttendanceThisMonthState extends State<AttendanceThisMonth> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAttendanceData();
    });
  }

  ///
  void _fetchAttendanceData() {
    context.read<AttendanceHistoryCubit>().attendanceHistory(
      month: selectedDate.month,
      year: selectedDate.year,
    );
  }

  void _selectMonth(BuildContext context) async {
    final pickedDate = await showMonthPicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    //
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      //
      _fetchAttendanceData();
    }
  }

  /// دالة لتحويل رقم الشهر إلى اسم مختصر (مثل 1 -> 'Jan')
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
    // التأكد من أن الشهر ضمن النطاق الصحيح (1-12)
    if (month < 1 || month > 12) {
      return 'ERR';
    }
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Attendance', // تم تغيير النص ليكون أكثر عمومية
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () => _selectMonth(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: primaryColor, width: 1.5),
            ),
            child: Row(
              children: [
                Text(
                  // عرض الشهر والسنة المحددين
                  '${getMonthName(selectedDate.month)}, ${selectedDate.year}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.calendar_month_outlined, // أيقونة أكثر ملاءمة
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
