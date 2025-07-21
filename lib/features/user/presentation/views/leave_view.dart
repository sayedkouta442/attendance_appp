import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeaveView extends StatelessWidget {
  const LeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
          title: const Text('Leave '),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Leave Request'),
              Tab(text: 'Leave Status'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [LeaveRequestForm(), LeaveStatusList()],
        ),
      ),
    );
  }
}

class LeaveRequestForm extends StatelessWidget {
  const LeaveRequestForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
            onChanged: (value) {},
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Select leave type',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "From Date",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'DD/MM/YYYY',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () {
              // Show date picker here
            },
          ),
          const SizedBox(height: 16),
          const Text("To Date", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'DD/MM/YYYY',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () {
              // Show date picker here
            },
          ),
          const SizedBox(height: 16),
          const Text("Reason", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter reason for leave',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Submit leave request
            },
            child: const Text('Submit Request'),
          ),
        ],
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
