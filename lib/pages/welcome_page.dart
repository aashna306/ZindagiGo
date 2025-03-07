import 'package:flutter/material.dart';
import 'package:gsc_project/main.dart';
import 'package:gsc_project/pages/new_Account.dart';
import 'package:gsc_project/pages/login_page.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import '../services/auth_service.dart';
void main() {
  runApp(const MyApp());
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    _initDynamicLinks();
  }

  void _initDynamicLinks() async {
    // For dynamic links when the app is running in the foreground.
    // ignore: deprecated_member_use
    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData? dynamicLinkData) async {
        final Uri? deepLink = dynamicLinkData?.link;
        if (deepLink != null) {
          await AuthService().handleIncomingLink(deepLink.toString(), context);
        }
      },
      onError: (error) async {
        print('Dynamic Link Error: $error');
      },
    );

    // For dynamic links when the app is launched from a terminated state.
    final PendingDynamicLinkData? initialLink =
        // ignore: deprecated_member_use
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      await AuthService().handleIncomingLink(deepLink.toString(), context);
    }
  }

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
