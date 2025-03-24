import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/main.dart';
import 'package:gsc_project/pages/home_page.dart';
import 'package:gsc_project/colors/app_colors.dart';
import 'package:gsc_project/pages/login_by_phoneno.dart';
import '../services/mongo_service.dart';
import '../services/auth_service.dart';
import 'userInfo.dart';

void main() {
  runApp(const MyApp());
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

//function to login using email-password

  Future<void> loginWithEmail() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false, // Remove all previous routes
      );
    } catch (e) {
      print("Login Error: $e");
    }
  }


    void loginWithGoogle(BuildContext context) async {
    var usern = await AuthService().signInWithGoogle();
    if (usern?.user != null) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
      String email = usern!.user!.email!;
      bool exists = await MongoService().checkIfEmailExists(email);
      print("Email Exists in DB: $exists");
      if (exists) {
        // Email exists, go to HomePage
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
      } else {
        // Email doesn't exist, go to UserInfoPage
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => UserInfoPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: AppColors.pink,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              const Icon(
                Icons.favorite,
                color: AppColors.pink,
                size: 70,
              ),
              const SizedBox(height: 20),
              const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email, color: AppColors.lineColor),
                    labelText: "Enter Email",
                    labelStyle: TextStyle(color: AppColors.InputInfo),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.lineColor, width: 3.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.pink, width: 3.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock, color: AppColors.lineColor),
                    labelText: "Enter Password",
                    labelStyle: TextStyle(color: AppColors.InputInfo),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.lineColor, width: 3.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.pink, width: 3.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.lineColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginWithEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lineColor,
                  iconColor: AppColors.pink,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                "Or login using...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      icon: Image.asset("lib/imagesOrlogo/Google.png"),
                      iconSize: 40,
                      onPressed: () {
                        // Add your onPressed code here!
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => GoogleLoginScreen()));

                         loginWithGoogle(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      icon: Image.asset("lib/imagesOrlogo/Gmail.png"),
                      iconSize: 40,
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      icon: Image.asset("lib/imagesOrlogo/PhoneNo.png"),
                      iconSize: 40,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  LoginByPhoneno()),
                          );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
