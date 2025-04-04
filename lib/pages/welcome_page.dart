import 'package:flutter/material.dart';
import 'package:gsc_project/main.dart';
import 'package:gsc_project/pages/new_Account.dart';
import 'package:gsc_project/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFD4859E), // Solid pink background
          child: Column(
            children: [
              // Logo Container
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 20),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD4859E),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'lib/imagesOrlogo/ZindagiGo_logo.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ),

              // Bottom Container
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF5F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFF594087),
                      width: 5,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Welcome Text
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontFamily: 'Poppins',
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'to',
                      style: TextStyle(
                        color: Color(0xFF444444),
                        fontFamily: 'Poppins',
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Zindagi Go Text
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Zindagi ',
                            style: GoogleFonts.caveat(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Go!',
                            style: GoogleFonts.nunito(
                              color: Color(0xFF5A4087),
                              fontSize: 42,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Subtitle
                    Text(
                      'Because Life Doesn\'t Pause with Age',
                      style: GoogleFonts.caveat(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.3,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Login and Signup Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4A4191), // Deep purple
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NewAccountPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4A4191), // Deep purple
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Text(
                              'Signup',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
