import 'package:attendance_app/bottom_navigation_widget.dart';
import 'package:attendance_app/features/auth/views/login_view.dart';
import 'package:attendance_app/features/home/views/home_view.dart';
import 'package:attendance_app/features/notifications/presentation/views/notifications_view.dart';
import 'package:attendance_app/features/user/views/user_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kLoginView = '/login';
  static const kHomeView = '/home';
  static const kLocationView = '/location';
  static const kFaceIdView = '/face_id';
  static const kSuccessView = '/success';
  static const kNotificationsView = '/notifications';
  static const kLeaveRequestView = '/leaveRequest';
  static const kProfileView = '/profile';
  static const kUserView = '/user_view';

  static final router = GoRouter(
    initialLocation: kHomeView,
    routes: [
    
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomNavigation(navigationShell: navigationShell);
        },
    branches: , 
   ),




      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(path: kNotificationsView, builder: (context, state) => const NotificationsView()),
      GoRoute(path: kUserView, builder: (context, state) => const UserView()),
    ],
  );
}
