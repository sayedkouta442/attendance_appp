import 'package:attendance_appp/core/utils/constants.dart';
import 'package:attendance_appp/features/leave/data/models/leave_model.dart';
import 'package:attendance_appp/features/leave/presentation/view_model/cubit/leave_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({super.key});

  @override
  State<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _reason = TextEditingController();
  String? leaveType = '';
  final _formKey = GlobalKey<FormState>();

  DateTime? _fromDate;
  DateTime? _toDate;

  Future<void> _selectDate(
    BuildContext context, {
    required bool isFromDate,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = pickedDate;

          _fromDateController.text = DateFormat(
            'dd/MM/yyyy',
          ).format(pickedDate);

          if (_toDate != null && _toDate!.isBefore(_fromDate!)) {
            _toDate = null;
            _toDateController.clear();
          }
        } else {
          if (_fromDate != null && pickedDate.isBefore(_fromDate!)) {
            //
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("'To Date' cannot be before 'From Date'."),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            _toDate = pickedDate;
            _toDateController.text = DateFormat(
              'dd/MM/yyyy',
            ).format(pickedDate);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    //
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text(
              "Leave Type",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'Sick', child: Text('Sick Leave')),
                DropdownMenuItem(value: 'Casual', child: Text('Casual Leave')),
                DropdownMenuItem(value: 'Annual', child: Text('Annual Leave')),
              ],

              onChanged: (value) {
                leaveType = value;
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                hintText: 'Select leave type',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This Field is Required';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "From Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            //
            TextFormField(
              controller: _fromDateController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                hintText: 'DD/MM/YYYY',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This Field is Required';
                }

                return null;
              },
              readOnly: true,
              onTap: () {
                _selectDate(context, isFromDate: true);
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "To Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _toDateController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                hintText: 'DD/MM/YYYY',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This Field is Required';
                }

                return null;
              },
              readOnly: true,
              onTap: () {
                _selectDate(context, isFromDate: false);
              },
            ),
            const SizedBox(height: 16),
            const Text("Reason", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _reason,
              maxLines: 3,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(12)),
                // ),
                hintText: 'Enter reason for leave',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This Field is Required';
                }

                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final leave = LeaveModel(
                    employeeId: userId,
                    leaveType: leaveType ?? '',
                    fromDate: DateFormat(
                      'dd/MM/yyyy',
                    ).parse(_fromDateController.text),
                    toDate: DateFormat(
                      'dd/MM/yyyy',
                    ).parse(_toDateController.text),

                    reason: _reason.text,
                  );
                  // supmit request

                  try {
                    await context.read<LeaveCubit>().leaveRequest(leave);

                    if (context.mounted) {
                      SuccessDialog(context);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Submission failed: $e')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: primaryColor,
                foregroundColor: Colors.transparent,
                textStyle: TextStyle(color: Colors.white),
              ),
              child: Text(
                'Submit Request',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              // : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> SuccessDialog(BuildContext context) {
    return showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Leave Request Submitted'),
        content: const Text(
          'Your request has been sent. Please wait for the admin response.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              (context).pop();
              (context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
