import 'package:flutter/material.dart';
import 'package:gsc_project/main.dart';
import 'package:gsc_project/pages/UserloginorSignup.dart';
import 'package:gsc_project/pages/loginPageCaretaker.dart';
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
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      await AuthService().handleIncomingLink(deepLink.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    final bool isSmallScreen = screenWidth < 600; 

    return Scaffold(
      body: Container(
        color: const Color(0xFFD4859E), 
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight,
            ),
            child: IntrinsicHeight( 
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.45, 
                    color: const Color(0xFFD4859E),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.05), 
                        child: Container(
                          width: isSmallScreen ? screenWidth * 0.85 : screenWidth * 0.6, 
                          height: isSmallScreen ? screenWidth * 0.85 : screenWidth * 0.6, 
                          decoration: const BoxDecoration(
                            color: Color(0xFFD4859E), 
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              'lib/imagesOrlogo/ZindagiGo_logo.png',
                              width: isSmallScreen ? screenWidth * 0.55 : screenWidth * 0.35, 
                              height: isSmallScreen ? screenWidth * 0.55 : screenWidth * 0.35,
                              fit: BoxFit.contain, // Ensures image fits within its bounds
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Bottom white section
                  Expanded( // This makes the bottom container fill the remaining vertical space
                    child: Container(
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
                      child: Padding( // Add overall padding to the content within the white section
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.08, // 8% of screen width horizontal padding
                          vertical: screenHeight * 0.03, // 3% of screen height vertical padding
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // "Welcome to" text - responsive font size
                            FittedBox( // Ensures text fits within available space
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Welcome',
                                style: TextStyle(
                                  color: const Color(0xFF444444),
                                  fontFamily: 'Poppins',
                                  // Use responsive font size
                                  fontSize: isSmallScreen ? 28 : 36, // Smaller on small, larger on big
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'to',
                                style: TextStyle(
                                  color: const Color(0xFF444444),
                                  fontFamily: 'Poppins',
                                  fontSize: isSmallScreen ? 28 : 36,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02), // Responsive spacing
        
                            // Zindagi Go! text - responsive font size
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Zindagi ',
                                      style: GoogleFonts.caveat(
                                        fontSize: isSmallScreen ? 36 : 48,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 2,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Go!',
                                      style: GoogleFonts.nunito(
                                        color: const Color(0xFF5A4087),
                                        fontSize: isSmallScreen ? 38 : 50,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02), // Responsive spacing
        
                            // Tagline text - responsive font size
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Because Life Doesn\'t Pause with Age',
                                textAlign: TextAlign.center, // Center align for better look on small screens
                                style: GoogleFonts.caveat(
                                  fontSize: isSmallScreen ? 22 : 30,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.3,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.05), // Responsive spacing
        
                            // Login and Signup Buttons
                            Column(
                              children: [
                                _buildActionButton(
                                  context: context,
                                  text: 'User',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const UserLoginOrSignup()),
                                    );
                                  },
                                  screenWidth: screenWidth,
                                ),
                                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                                _buildActionButton(
                                  context: context,
                                  text: 'Caretaker',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const LoginPageCaretaker()),
                                    );
                                  },
                                  screenWidth: screenWidth,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for building responsive buttons
  Widget _buildActionButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
    required double screenWidth,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4A4191),
        // Make button width responsive (e.g., 80% of screen width)
        minimumSize: Size(screenWidth * 0.8, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.045, // Responsive font size for buttons
        ),
      ),
    );
  }
}
