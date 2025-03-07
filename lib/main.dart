import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gsc_project/pages/MedicalRecords.dart';
import 'firebase_options.dart';
import 'package:gsc_project/pages/new_Account.dart';
import 'package:gsc_project/pages/home_page.dart';
import 'package:gsc_project/pages/userInfo.dart';
import 'pages/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false, 
      title: 'Flutter App',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/new_account': (context) => NewAccountPage(),
        '/user_info':(context) => UserInfoPage(),
        '/home': (context) => HomePage(),
        '/MedicalRecords': (context) => MedicalRecords(),
      },

      theme: ThemeData(),
    );
  }
}