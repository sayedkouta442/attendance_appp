import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

// هذا هو الكود الذي يجب أن يكون في ملف bottom_navigation.dart

class BottomNavigation extends StatelessWidget {
  /// The navigation shell that contains the state for the shell route.
  final StatefulNavigationShell navigationShell;

  const BottomNavigation({super.key, required this.navigationShell});

  /// This private method is called when a tab is tapped.
  /// It uses the navigationShell to navigate to the correct branch.
  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      // if the user is tapping on the same tab, we reset the navigator stack
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // We use WillPopScope to control the back button behavior.
    // This prevents the app from closing when the user is on a tab other than Home.
    return WillPopScope(
      onWillPop: () async {
        if (navigationShell.currentIndex != 0) {
          _onItemTapped(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        // This is the crucial part that displays the content of the current tab.
        body: navigationShell,
        // The BottomNavigationBar remains mostly the same.
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.05),
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              elevation: 80,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xff4e80c3),
              unselectedItemColor: isDarkMode
                  ? Colors.white.withOpacity(0.6)
                  : Colors.black.withOpacity(0.6),
              showUnselectedLabels: true,

              // The current index is now driven by the navigation shell.
              currentIndex: navigationShell.currentIndex,

              // The onTap callback triggers the navigation.
              onTap: _onItemTapped,

              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: '',
                  tooltip: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history_toggle_off_outlined),
                  label: '',
                  tooltip: 'Attendance History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: '',
                  tooltip: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined),
                  label: '',
                  tooltip: 'User',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
