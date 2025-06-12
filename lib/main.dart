import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gsc_project/pages/MedicalRecords.dart';
import 'package:gsc_project/pages/notifications.dart';
import 'firebase_options.dart';
import 'package:gsc_project/pages/new_Account.dart';
import 'package:gsc_project/pages/home_page.dart';
import 'package:gsc_project/pages/userInfo.dart';
import 'pages/splash_screen.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await checkAndRequestBatteryOptimization();
  await initializeBackgroundService();
    final service = FlutterBackgroundService();
  bool isRunning = await service.isRunning();
  if (!isRunning) {
    service.startService();
  }

  await NotificationService.initialize(); 
    runApp(MyApp());
}

Future<void> checkAndRequestBatteryOptimization() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isBatteryOptimizationDisabled =
      prefs.getBool('battery_optimization_disabled');

  if (!(isBatteryOptimizationDisabled ?? false)) {
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 23) {
      // Check if the Android version supports battery optimization
      var status = await Permission.ignoreBatteryOptimizations.status;

      if (!status.isGranted) {
        var result = await Permission.ignoreBatteryOptimizations.request();
        if (result.isGranted) {
          prefs.setBool('battery_optimization_disabled', true);
        }
      } else {
        prefs.setBool('battery_optimization_disabled', true);
      }
    }
  }
}

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: _onBackgroundServiceStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'background_service',
      initialNotificationTitle: 'Background Service Running',
      initialNotificationContent: 'Listening for fall detection...',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: _onBackgroundServiceStart,
      onBackground: _onBackgroundServiceStart,
    ),
  );

  bool isRunning = await service.startService();
  if (!isRunning) {
    print("Failed to start background service.");
  } else {
    print("Background service started successfully.");
  }
}

// Background service function
FutureOr<bool> _onBackgroundServiceStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "Zindagi Go - Fall Detection Active",
      content: "Monitoring your safety in the background.",
    );
  }

  // Periodically update the notification
  Timer.periodic(const Duration(seconds: 20), (timer) {
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Running in Background",
        content: "Monitoring background tasks...",
      );
    }
  });

  service.on('fallDetected').listen((event) {
    print("Fall detected in background!");
  });

  return true; // Ensure the function returns a boolean value
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/new_account': (context) => NewAccountPage(),
        '/user_info': (context) => UserInfoPage(),
        '/home': (context) => HomePage(),
        '/MedicalRecords': (context) => MedicalRecords(),
      },
      theme: ThemeData(),
    );
  }
}
