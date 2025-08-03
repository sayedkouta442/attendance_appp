import 'package:attendance_appp/core/utils/constants.dart';
import 'package:attendance_appp/core/utils/routs.dart';
import 'package:attendance_appp/core/utils/themes/text_theme.dart';
import 'package:attendance_appp/core/utils/themes/theme_controller.dart';
import 'package:attendance_appp/features/user/data/models/user_model.dart';
import 'package:attendance_appp/features/user/presentation/view_models/cubit/user_cubit.dart';
import 'package:attendance_appp/features/user/presentation/views/widgets/user_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    context.read<UserCubit>().fetchUserData();
    super.initState();
  }

  bool isLocationEnabled = false;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontSize: 24)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User avatar and name
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserFailure) {
                  return Center(
                    child: Text(
                      state.errMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is UserSuccess) {
                  final user = state.user;
                  final formattedDate = user.joinDate
                      .toLocal()
                      .toString()
                      .split(' ')[0];
                  //   print('User data fetched: ${user.fullName}');
                  return Column(
                    children: [
                      UerImage(user: user),
                      const SizedBox(height: 12),
                      Text(
                        user.fullName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${user.jobTitle} - ${user.department}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Divider(height: 32),

                      // User info
                      userInfo(user, formattedDate),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),

            const Divider(height: 32),

            ThemeToggleSwitch(
              //    title: 'Location',
              subTitle: 'Dark Theme',
              value: themeController.isDarkMode(context),
              onChanged: (isDark) {
                themeController.toggleTheme(isDark);
              },
            ),
            const SizedBox(height: 16),
            ThemeToggleSwitch(
              //    title: 'Location',
              subTitle: 'Update Your Location',
              value: isLocationEnabled,
              onChanged: (value) async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('location');

                setState(() => isLocationEnabled = value);
              },
            ),
            const SizedBox(height: 16),

            // Logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      await client.auth.signOut();
                      if (!context.mounted) return;
                      GoRouter.of(context).go('/');
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column userInfo(UserModel user, String formattedDate) {
    return Column(
      children: [
        _buildInfoTile(title: 'Email', value: user.email, icons: Icons.email),
        _buildInfoTile(
          title: 'Phone',
          value: user.phoneNumber,
          icons: Icons.phone,
        ),
        _buildInfoTile(
          title: 'Join Date',
          value: formattedDate,
          icons: Icons.date_range,
        ),
        _buildInfoTile(
          title: 'Branch',
          value: user.branch,
          icons: Icons.location_city,
        ),
      ],
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String value,
    required IconData icons,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      leading: Icon(icons),
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

class ThemeToggleSwitch extends StatefulWidget {
  const ThemeToggleSwitch({
    super.key,
    // required this.title,
    required this.subTitle,
    required this.value,
    required this.onChanged,
  });

  // final String title;
  final String subTitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<ThemeToggleSwitch> createState() => _ThemeToggleSwitchState();
}

class _ThemeToggleSwitchState extends State<ThemeToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textTheme = isDarkMode
        ? CTextTheme.darkTextTheme
        : CTextTheme.lightTextTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.subTitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: 'Montserrat',
            ),
          ),
          GestureDetector(
            onTap: () => setState(() {
              widget.onChanged(!widget.value);
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 60,
              height: 30,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: widget.value ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(34),
              ),
              alignment: widget.value
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
