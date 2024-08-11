import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live_score_application/routes/app_route.dart';
import 'package:live_score_application/screens/dashboard/view/dashboard_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool rememberPassword = true;

  TextEditingController emailController = TextEditingController();
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  bool validateEmail(String email) {
    String email0 = email.trim();
    return emailRegex.hasMatch(email0);
  }

  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegExp passValid = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");

  bool validatePassword(String pass) {
    String password = pass.trim();
    return passValid.hasMatch(password);
  }

  Future<void> saveUserLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        User? user = userCredential.user;

        if (user != null) {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          if (userDoc.exists) {
            await saveUserLoggedIn(true);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          } else {
            log('User not found in Firestore');
          }
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${ex.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 150,
                          height: 150,
                          color: Colors.black,
                          child: Stack(
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/image/football.png',
                                  width: 150,
                                  height: 150,
                                  color: Color(0xFFBBFF00),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "LivoScore",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Urbanist',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Urbanist',
                            fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email must not be empty';
                              } else if (!validateEmail(value)) {
                                return "Invalid email format";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 12.0),
                              hintStyle:
                              TextStyle(color: Colors.grey, fontFamily: 'Urbanist'),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Urbanist'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding:
                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                      child: Text(
                        'Password:',
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            obscureText: _obscureText,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password must not be empty';
                              } else if (!validatePassword(value)) {
                                return "Password should contain 8 Characters, including Capital, small letter and number";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 12.0),
                              hintStyle: const TextStyle(color: Colors.grey),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(
                                  _obscureText
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Urbanist'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Urbanist'),
                            ),
                            /*onTap: () => AppRoute().navigateToForget(context),*/
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: login,
                          icon: const Icon(Icons.login, color: Colors.black),
                          label: const Text(
                            'Log in',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontFamily: 'Urbanist'),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Or',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Urbanist',
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(MdiIcons.google,
                                    color: Colors.red, size: 30),
                                const SizedBox(width: 10, height: 20),
                                const Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.apple, size: 30),
                                SizedBox(width: 10, height: 20),
                                Text(
                                  'Continue with Apple',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 80),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontFamily: 'Urbanist'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppRoute().navigateToSignUpScreen(context);
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
