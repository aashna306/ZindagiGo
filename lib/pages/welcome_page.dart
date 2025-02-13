import 'package:flutter/material.dart';
import 'package:gsc_project/main.dart';
import 'package:gsc_project/pages/new_Account.dart';
import 'package:gsc_project/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Page 1
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewAccountPage()),
                );
              },
              child: Text('Create New Account'),
            ),
            SizedBox(height: 20), // Add some spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to Page 2
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Login to Existing Account'),
            ),
          ],
        ),
      ),
    );
  }
}