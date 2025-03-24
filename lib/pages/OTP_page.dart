import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/colors/app_colors.dart';
import 'package:gsc_project/pages/home_page.dart';

class OtpPage extends StatefulWidget {
  const OtpPage(
      {super.key, required this.phonenumber, required this.verificationId});
  final String phonenumber;
  final String verificationId;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  final FocusNode focusNodes = FocusNode();
  
  String getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }

  Future<void> verifyOtp() async {
    String otp = getOtpCode();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
      );
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: otp);

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Verification Failed: ${e.toString()}")),
      );
    }
  }
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
                      controller: otpControllers[index],
                      focusNode: focusNodes,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                            counterText: "",
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.lineColor, width: 3.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.pink, width: 3.0),
                        ),
                        // enabledBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //       color: AppColors.lineColor, width: 3.0),
                        // ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide:
                        //       BorderSide(color: AppColors.pink, width: 3.0),
                        // ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                        onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
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
              onPressed: verifyOtp ,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ButtonColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
              child: const Text(
                "Verify",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
