import 'package:attendance_appp/core/common/api_keys.dart';
import 'package:attendance_appp/core/utils/notifier.dart';
import 'package:attendance_appp/core/utils/routs.dart';
import 'package:attendance_appp/core/utils/themes/theme.dart';
import 'package:attendance_appp/core/utils/themes/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  checkInNotifier.value = prefs.getBool('checkedIn') ?? false;

  await Supabase.initialize(
    url: ApiKeys.supabaseUrl,
    anonKey: ApiKeys.supabaseAnonKey,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeController(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Color(0xff3662e1), // Blue color
    //     statusBarIconBrightness: Brightness.light,
    //   ),
    // );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: themeController.themeMode,
      theme: CAppTheme.lightTheme,
      darkTheme: CAppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
