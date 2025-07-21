import 'package:attendance_appp/core/utils/constants.dart';
import 'package:attendance_appp/core/utils/routs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User avatar and name
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/p5.jpg',
              ), // Replace with your image
            ),
            const SizedBox(height: 12),
            const Text(
              'Mohamed Ali',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Flutter Developer - Tech Department',
              style: TextStyle(color: Colors.grey),
            ),
            const Divider(height: 32),

            // User info
            _buildInfoTile(title: 'Email', value: 'mohamed@example.com'),
            _buildInfoTile(title: 'Phone', value: '01000000000'),
            _buildInfoTile(title: 'Join Date', value: '2023-04-01'),
            _buildInfoTile(title: 'Branch', value: 'Cairo'),

            const Divider(height: 32),

            // Settings
            // _buildSettingsItem(
            //   icon: Icons.language,
            //   title: 'Change Language',
            //   onTap: () {},
            // ),
            _buildSettingsItem(
              icon: Icons.logout_sharp,
              title: 'Leave ',
              onTap: () {
                GoRouter.of(context).push(AppRouter.kLeaveView);
              },
            ),
            _buildSettingsItem(
              icon: Icons.notifications_active_rounded,
              title: 'Notification Settings',
              onTap: () {},
            ),
            // _buildSettingsItem(
            //   icon: Icons.dark_mode_outlined,
            //   title: 'Dark Mode',
            //   onTap: () {},
            // ),
            _buildSettingsItem(
              icon: Icons.location_on_outlined,
              title: 'Update Location',
              onTap: () {},
            ),

            const SizedBox(height: 24),

            // Logout
            ElevatedButton.icon(
              onPressed: () {
                client.auth.signOut();
                GoRouter.of(context).go('/');
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({required String title, required String value}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      leading: const Icon(Icons.info_outline),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
