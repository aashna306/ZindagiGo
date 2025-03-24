import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/colors/app_colors.dart';
// import 'package:gsc_project/main.dart';
import 'package:gsc_project/pages/OTP_page.dart';

class LoginByPhoneno extends StatefulWidget {
  const LoginByPhoneno({super.key});

  @override
  _LoginByPhonenoState createState() => _LoginByPhonenoState();
}

class _LoginByPhonenoState extends State<LoginByPhoneno> {
  final TextEditingController phoneController = TextEditingController();
   String? verificationId;


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: AppColors.pink,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Icon(
              Icons.favorite,
              color: AppColors.pink,
              size: 50,
            ),
            const SizedBox(height: 20),
            const Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextFormField(controller: phoneController,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone, color: AppColors.lineColor),
                  labelText: "Enter your Phone Number",
                  labelStyle: TextStyle(color: AppColors.InputInfo),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lineColor, width: 2.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.ButtonColor, width: 2.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
            SizedBox(
              width: screenWidth - 40, // Adjust width based on screen size
              height: 50,
              child: ElevatedButton(
                onPressed: () async{
            FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (PhoneAuthCredential){}, 
              verificationFailed:(error){
                print(error.toString());
              }, 
              codeSent: (verificationId, forcereSendingToken){
Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpPage(phonenumber:phoneController.text, verificationId:verificationId)));
              },
             codeAutoRetrievalTimeout: (verificationId){
              print("auto retrivel time out");
             });
          }
                //  () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const OtpPage()),
                //   );
                // }
                ,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "Generate OTP",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              "lib/imagesOrlogo/OTPbottom.png",
              height: 270,
              width: screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}
