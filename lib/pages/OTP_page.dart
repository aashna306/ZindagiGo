import 'package:flutter/material.dart';
import 'package:gsc_project/colors/app_colors.dart';
import 'package:gsc_project/main.dart';
import 'package:gsc_project/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Image.asset(
              "lib/imagesOrlogo/PhoneOTP.png",
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter the 6 digit OTP sent to this phone number :",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Text(
              "XXXXXXXXXX",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 40,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lineColor, width: 3.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.pink, width: 3.0),
                        ),
                      ),
                      //keyboardType: TextInputType.number,
                      //maxLength: 1,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Add resend OTP functionality here
              },
              child: const Text(
                "Resend OTP?",
                style: TextStyle(
                  color: AppColors.pink,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ButtonColor,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
              child: const Text(
                  "Verify",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}