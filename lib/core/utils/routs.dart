import 'package:attendance_appp/bottom_navigation_widget.dart';
import 'package:attendance_appp/features/atten_history/data/data_sources/attendance_history_remote_data_source.dart';
import 'package:attendance_appp/features/atten_history/data/repos/attendance_history_repo.dart';
import 'package:attendance_appp/features/atten_history/presentation/view_model/cubit/attendance_history_cubit.dart';
import 'package:attendance_appp/features/atten_history/presentation/views/attendance_history.dart';
import 'package:attendance_appp/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:attendance_appp/features/auth/data/repos_imple/repos_impl.dart';
import 'package:attendance_appp/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:attendance_appp/features/auth/presentation/views/login_view.dart';
import 'package:attendance_appp/features/leave/data/apis/leave_remote_data_source.dart';
import 'package:attendance_appp/features/leave/data/repos/leave_repo.dart';
import 'package:attendance_appp/features/leave/presentation/view_model/cubit/leave_cubit.dart';
import 'package:attendance_appp/features/record_attendance/data/data_sources/attendance_remote_data_source.dart';
import 'package:attendance_appp/features/record_attendance/data/repos_impl/record_attendance_repo_impl.dart';
import 'package:attendance_appp/features/record_attendance/presentation/view_model/cubit/record_attendance_cubit.dart';
import 'package:attendance_appp/features/record_attendance/presentation/views/face_recognition_view.dart';
import 'package:attendance_appp/features/record_attendance/presentation/views/success_view.dart';
import 'package:attendance_appp/features/home/presentation/views/home_view.dart';
import 'package:attendance_appp/features/record_attendance/presentation/views/check_location_view.dart';
import 'package:attendance_appp/features/notifications/presentation/views/notifications_view.dart';
import 'package:attendance_appp/features/user/data/apis/user_remote_data_source.dart';
import 'package:attendance_appp/features/user/data/repos/user_repo_impl.dart';
import 'package:attendance_appp/features/user/presentation/view_models/cubit/user_cubit.dart';
import 'package:attendance_appp/features/leave/presentation/views/leave_view.dart';
import 'package:attendance_appp/features/user/presentation/views/user_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  static const kLeaveView = '/leave_view';
  //static const kBottomNavigation = '/bottom_navigation';

  static final router = GoRouter(
    initialLocation: '/',

    redirect: (context, state) async {
      final prefs = await SharedPreferences.getInstance();
      final requirePostLogin = prefs.getBool('requirePostSignupLogin') ?? false;
      final currentPath = state.uri.path;
      final session = Supabase.instance.client.auth.currentSession;

      if (requirePostLogin) {
        return kLoginView;
      }

      if (session == null && currentPath != kLoginView) {
        return kLoginView;
      }
      if (session != null &&
          (currentPath == '/' || currentPath == kLoginView)) {
        return kHomeView;
      }

      return null;
    },
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
                  return BlocProvider(
                    create: (context) => AttendanceHistoryCubit(
                      AttendanceHistoryRepoImpl(
                        AttendanceHistoryRemoteDataSourceImpl(),
                      ),
                    ),
                    child: HomeView(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kAttendanceHistoryView,
                builder: (context, state) {
                  return BlocProvider(
                    create: (context) => AttendanceHistoryCubit(
                      AttendanceHistoryRepoImpl(
                        AttendanceHistoryRemoteDataSourceImpl(),
                      ),
                    ),
                    child: AttendanceHistoryView(),
                  );
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
                  return BlocProvider(
                    create: (context) => UserCubit(
                      UserRepoImpl(UserRemoteDataSourceImpl())..fetchUserData(),
                    ),
                    child: UserView(),
                  );
                },
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: kLoginView,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              AuthCubit(AuthRepoImpl(AuthRemoteDataSourceImpl())),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kLocationView,
        builder: (context, state) => const CheckLocationView(),
      ),
      GoRoute(
        path: kFaceIdView,
        builder: (context, state) => BlocProvider(
          create: (context) => RecordAttendanceCubit(
            RecordAttendanceRepoImpl(RecordAttendanceRemoteDataSourceImpl()),
          ),
          child: const FaceRecognitionView(),
        ),
      ),
      GoRoute(
        path: kSuccessView,
        builder: (context, state) => const SuccessView(),
      ),
      GoRoute(
        path: kLeaveView,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              LeaveCubit(LeaveRepoImpl(LeaveRemoteDateSourceImpl())),
          child: const LeaveView(),
        ),
      ),
    ],
  );
}
