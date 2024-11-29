import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


// Screens
import 'screens/attendance_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/grading_screen.dart';
import 'screens/login_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/attendance_insights_screen.dart';

// Services
import 'services/analytics_service.dart';
import 'services/grading_service.dart';
import 'services/lesson_service.dart';
import 'services/offline_service.dart';

// Third-party utilities
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('attendance'); // Example box for attendance data
  await Hive.openBox('grades'); // Example box for grades

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Local Notifications
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid = 
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = 
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add your services as providers if using Provider for state management
        Provider(create: (_) => AnalyticsService()),
        Provider(create: (_) => GradingService()),
        Provider(create: (_) => LessonService()),
        Provider(create: (_) => OfflineService()),
      ],
      child: MaterialApp(
        title: 'AI Teacher Tools',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/attendance': (context) => AttendanceScreen(),
          '/attendance-insights': (context) => AttendanceInsightsScreen(),
          '/grading': (context) => GradingScreen(),
          '/settings': (context) => SettingsScreen(),
        },
      ),
    );
  }
}
