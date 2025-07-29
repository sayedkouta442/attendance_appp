import 'package:attendance_appp/features/leave/presentation/view_model/cubit/leave_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class LeaveStatusList extends StatefulWidget {
  const LeaveStatusList({super.key});

  @override
  State<LeaveStatusList> createState() => _LeaveStatusListState();
}

class _LeaveStatusListState extends State<LeaveStatusList> {
  @override
  void initState() {
    context.read<LeaveCubit>().leaveStatus();
    super.initState();
  }

  Color getStatusColor(String status) {
    final Color color;
    if (status == 'Rejected') {
      color = Colors.red;
    } else if (status == 'Approved') {
      color = Colors.green;
    } else {
      color = Colors.orange;
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveCubit, LeaveState>(
      builder: (context, state) {
        if (state is LeaveStatusSuccess) {
          final leave = state.leave;
          return ListView.builder(
            padding: const EdgeInsets.all(16),

            itemCount: leave.length,
            itemBuilder: (context, index) {
              final item = leave[index];
              //  final DateTime? requestDate;

              final String? status = item.status;

              final String leaveType = item.leaveType;
              final requestDate = DateFormat(
                'dd/MM/yyyy',
              ).format(item.requestDate!);
              final stratDate = DateFormat('dd/MM/yyyy').format(item.fromDate);
              final endDate = DateFormat('dd/MM/yyyy').format(item.toDate);
              return LeaveStatusListViewItem(
                requestDate: requestDate,
                status: status ?? '',
                leaveType: leaveType,
                startDate: stratDate,
                endDate: endDate,
                color: getStatusColor(status!),
              );
            },
          );
        } else if (state is LeaveFailure) {
          return Center(child: Text('Failed to fetch Leave Status'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class LeaveStatusListViewItem extends StatelessWidget {
  const LeaveStatusListViewItem({
    super.key,
    required this.requestDate,
    required this.status,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.color,
  });

  final String requestDate;
  final String status;
  final String leaveType;
  final String startDate;
  final String endDate;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(.09),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$requestDate',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              Text(
                status,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            leaveType,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            'Duration: $startDate – $endDate',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
