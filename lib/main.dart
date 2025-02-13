import 'package:flutter/material.dart';
import 'package:gsc_project/pages/new_Account.dart';
import 'package:gsc_project/pages/home_page.dart';
import 'package:gsc_project/pages/userInfo.dart';
import 'package:gsc_project/pages/welcome_page.dart';

void main() {
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
        '/': (context) => WelcomePage(),
        '/new_account': (context) => NewAccountPage(),
        '/user_info':(context) => UserInfoPage(),
        '/home': (context) => HomePage(),
      },

      theme: ThemeData(
      ),
    );
  }
}
