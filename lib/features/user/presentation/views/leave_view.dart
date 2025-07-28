import 'package:attendance_appp/core/utils/constants.dart';
import 'package:attendance_appp/core/utils/pop_arrow.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LeaveView extends StatelessWidget {
  const LeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: PopArrow(),
          title: const Text('Leave '),
          centerTitle: true,
          bottom: TabBar(
            padding: EdgeInsets.only(top: 20),
            dividerColor: Colors.transparent,
            indicatorColor: primaryColor,
            labelColor: primaryColor,
            tabs: [
              Tab(text: 'Leave Request'),
              Tab(text: 'Leave Status'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: TabBarView(children: [LeaveRequestForm(), LeaveStatusList()]),
        ),
      ),
    );
  }
}

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({super.key});

  @override
  State<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _reason = TextEditingController();
  String? leaveReason = '';
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
            // عرض رسالة خطأ للمستخدم
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
                leaveReason = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
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
                border: OutlineInputBorder(),
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
                border: OutlineInputBorder(),
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
                border: OutlineInputBorder(),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // supmit request

                  //
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Leave Request Submitted Successfuly'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaveStatusList extends StatelessWidget {
  const LeaveStatusList({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    final leaveHistory = [
      {'type': 'Sick', 'date': '2025-07-01', 'status': 'Approved'},
      {'type': 'Annual', 'date': '2025-06-15', 'status': 'Pending'},
      {'type': 'Casual', 'date': '2025-05-20', 'status': 'Rejected'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: leaveHistory.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final item = leaveHistory[index];
        return ListTile(
          leading: const Icon(Icons.request_page),
          title: Text('${item['type']} Leave'),
          subtitle: Text('Date: ${item['date']}'),
          trailing: Text(
            item['status']!,
            style: TextStyle(
              color: item['status'] == 'Approved'
                  ? Colors.green
                  : item['status'] == 'Rejected'
                  ? Colors.red
                  : Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
