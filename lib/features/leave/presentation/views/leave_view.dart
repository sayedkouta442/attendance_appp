import 'package:attendance_appp/core/utils/constants.dart';
import 'package:attendance_appp/core/utils/pop_arrow.dart';
import 'package:attendance_appp/features/leave/data/models/leave_model.dart';
import 'package:attendance_appp/features/leave/presentation/view_model/cubit/leave_cubit.dart';
import 'package:attendance_appp/features/leave/presentation/views/widgets/leave_request.dart';
import 'package:attendance_appp/features/leave/presentation/views/widgets/leave_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
