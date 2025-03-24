import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gsc_project/pages/MedicalRecords.dart';
import 'firebase_options.dart';
import 'package:gsc_project/pages/new_Account.dart';
import 'package:gsc_project/pages/home_page.dart';
import 'package:gsc_project/pages/userInfo.dart';
import 'pages/splash_screen.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeBackgroundService();
  runApp(const MyApp());
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

  service.startService();
}

// Background service function
FutureOr<bool> _onBackgroundServiceStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
  }

  accelerometerEventStream().listen((event) {
    double acceleration =
        sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

    if (acceleration < 2.0) {
      service.invoke('fallDetected', {"message": "Fall detected!"});
    }
  });

  return true;
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
