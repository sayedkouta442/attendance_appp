import 'package:attendance_appp/bottom_navigation_widget.dart';
import 'package:attendance_appp/features/atten_history/presentation/views/attendance_history.dart';
import 'package:attendance_appp/features/auth/presentation/views/login_view.dart';
import 'package:attendance_appp/features/faceId/presentation/views/face_id_view.dart';
import 'package:attendance_appp/features/faceId/presentation/views/success_view.dart';
import 'package:attendance_appp/features/home/presentation/views/home_view.dart';
import 'package:attendance_appp/features/location/presentation/views/check_location_view.dart';
import 'package:attendance_appp/features/notifications/presentation/views/notifications_view.dart';
import 'package:attendance_appp/features/user/presentaion/views/user_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kLoginView = '/login';
  static const kHomeView = '/home';
  static const kLocationView = '/location';
  static const kFaceIdView = '/face_id';
  static const kSuccessView = '/success';
  static const kNotificationsView = '/notifications';
  static const kAttendanceHistoryView = '/attendance_history';
  static const kProfileView = '/profile';
  static const kUserView = '/user_view';
  //static const kBottomNavigation = '/bottom_navigation';

  static final router = GoRouter(
    initialLocation: kHomeView,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomNavigation(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kHomeView,
                builder: (context, state) {
                  return HomeView();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kAttendanceHistoryView,
                builder: (context, state) {
                  return AttendanceHistory();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kNotificationsView,
                builder: (context, state) {
                  return NotificationsView();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kUserView,
                builder: (context, state) {
                  return UserView();
                },
              ),
            ],
          ),
        ],
      ),

      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),
      GoRoute(
        path: kLocationView,
        builder: (context, state) => const CheckLocationView(),
      ),
      GoRoute(
        path: kFaceIdView,
        builder: (context, state) => const FaceRecognitionView(),
      ),
      GoRoute(
        path: kSuccessView,
        builder: (context, state) => const SuccessView(),
      ),
    ],
  );
}
