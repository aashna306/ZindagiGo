import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home_page.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔹 Sign Up with Email & Password
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user info in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'createdAt': DateTime.now(),
      });

      return userCredential;
    } catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }

  // 🔹 Log In with Email & Password
  Future<UserCredential?> loginWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  // 🔹 Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // if (googleUser == null) return null;

      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential usern = await _auth.signInWithCredential(credential);
      return usern;
      // return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  // 🔹 Phone Authentication - Send OTP
  Future<void> sendOTP(String phoneNumber, Function(String) onCodeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Phone Verification Failed: $e");
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // 🔹 Verify OTP and Sign In
  Future<UserCredential?> verifyOTP(
      String verificationId, String smsCode) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("OTP Verification Error: $e");
      return null;
    }
  }

  // 🔹 Magic Link Authentication (Email Without Password)
  Future<void> sendMagicLink(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://authenticating.page.link/amTC?email=$email',
          handleCodeInApp: true,
          androidPackageName: 'com.example.lasttry',
          androidInstallApp: false,
          androidMinimumVersion: '23',
        ),
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('emailForSignIn', email);
      print("Magic Link Sent to $email");
    } catch (e) {
      print("Magic Link Error: $e");
    }
  }



Future<void> handleIncomingLink(String link,BuildContext context) async {
  // Check if the link is a valid email sign-in link
  if (FirebaseAuth.instance.isSignInWithEmailLink(link)) {
    // Retrieve the stored email address
    final prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('emailForSignIn');

    if (email == null) {
      print('No email found in local storage. Please re-enter your email.');
      return;
    }

    try {
      // Complete the sign-in process
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailLink(email: email, emailLink: link);

      print('Successfully signed in with email link!');
      // Optionally, remove the stored email once sign-in is complete
      await prefs.remove('emailForSignIn');
 Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
      // After sign-in, you can navigate to another screen
    } catch (error) {
      print('Error signing in with email link: $error');
    }
  } else {
    print('The link is not a valid sign-in email link.');
  }
}

 

  // 🔹 Logout
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}
