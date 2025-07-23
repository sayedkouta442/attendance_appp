import 'package:attendance_appp/core/utils/constants.dart';
import 'package:attendance_appp/core/utils/routs.dart';
import 'package:attendance_appp/features/user/presentation/view_models/cubit/user_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
                  print('User data fetched: ${user.fullName}');
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: CachedNetworkImage(
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: imageProvider,
                              ),
                          fit: BoxFit.cover,
                          imageUrl: user.imageUrl ?? '',
                          errorWidget: (context, url, error) {
                            return CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(Icons.person, size: 50),
                            );
                          },
                          placeholder: (context, url) => const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
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
                      _buildInfoTile(title: 'Email', value: user.email),
                      _buildInfoTile(title: 'Phone', value: user.phoneNumber),
                      _buildInfoTile(title: 'Join Date', value: formattedDate),
                      _buildInfoTile(title: 'Branch', value: user.branch),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),

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
