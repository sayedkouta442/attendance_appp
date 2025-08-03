import 'package:attendance_appp/core/common/page_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PageTitle(title: 'Notifications'),
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            StatefulNavigationShell.of(context).goBranch(0);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

      body: Center(
        child: Text(
          'No notifications at the moment.',
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
      ),
    );
  }
}
