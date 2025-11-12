import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/services/auth_service.dart';
import 'core/network/api_client.dart';
import 'services/fcm_service.dart';
import 'services/local_notification_service.dart';
import 'features/auth/pages/splash_page.dart';
import 'features/auth/pages/member_registration_page.dart';
import 'features/members/pages/quick_registration_page.dart';
import 'features/supporters/pages/supporter_registration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize services
  await AuthService.init();

  // Initialize API client
  ApiClient().initialize();

  // Initialize FCM service
  await FcmService().initialize();
  await FcmService().setupMessageHandlers();

  // Set environment (can be changed based on build configuration)
  AppConfig.setEnvironment(Environment.production);

  runApp(
    const ProviderScope(
      child: NCMApp(),
    ),
  );
}

class NCMApp extends ConsumerWidget {
  const NCMApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
          home: const SplashPage(),
          routes: {
            '/member-registration': (context) => const MemberRegistrationPage(),
            '/quick-registration': (context) => const QuickRegistrationPage(),
            '/supporter-registration': (context) => const SupporterRegistrationPage(),
          },
        );
      },
    );
  }
}

// TODO: Implement proper routing with GoRouter
// TODO: Add proper state management providers
// TODO: Add error handling and logging
// TODO: Add internationalization support