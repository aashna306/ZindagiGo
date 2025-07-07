import 'package:flutter/material.dart';
import 'package:gsc_project/colors/app_colors.dart';
import 'package:gsc_project/pages/addContact.dart';
import 'package:gsc_project/pages/welcome_page.dart';
import 'package:gsc_project/services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help Numbers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: const HelpNumbersPage(),
    );
  }
}

class HelpNumbersPage extends StatelessWidget {
  const HelpNumbersPage({super.key});

  Future<void> _launchPhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void logout(BuildContext context) async {
    await AuthService().signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => WelcomePage()));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      appBar: AppBar(
        backgroundColor: AppColors.navBarColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Help Numbers",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Don't worry — just tap a number, help is on the way",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF0C134F),
                ),
              ),
              const SizedBox(height: 24),
              _buildEmergencyButton(context, 'Ambulance', '102', const Color(0xFFE2E0F0), screenWidth),
              const SizedBox(height: 12),
              _buildEmergencyButton(context, 'Elder Line', '14567', const Color(0xFFE2E0F0), screenWidth),
              const SizedBox(height: 12),
              _buildEmergencyButton(context, 'Helpage India\n(Elder Helpline)', '1800-180-1253', const Color(0xFFE2E0F0), screenWidth),
              const SizedBox(height: 12),
              _buildEmergencyButton(context, 'Dignity Foundation', '1800 267 8780', const Color(0xFFE2E0F0), screenWidth),
              const SizedBox(height: 12),
              _buildEmergencyButton(context, 'Police Helpline\n(Senior Citizens)', '1291', const Color(0xFFE2E0F0), screenWidth),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.center,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddHelpNumberPage()),
                    );
                  },
                  backgroundColor: const Color(0xFF0C134F),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyButton(
    BuildContext context,
    String title,
    String number,
    Color buttonColor,
    double screenWidth,
  ) {
    return ElevatedButton(
      onPressed: () => _launchPhoneCall(number),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        minimumSize: Size(screenWidth * 0.85, 60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0C134F),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            number,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0C134F),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF7FC8AA),
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.phone,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
