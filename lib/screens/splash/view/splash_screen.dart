import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:live_score_application/routes/app_route.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
    checkUserLoggedInStatus();
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  void checkUserLoggedInStatus() async {
    bool isLoggedIn = await isUserLoggedIn();
    if (isLoggedIn) {
      AppRoute().navigateToDashboardScreen(context);
    } else {
      AppRoute().navigateToOnboardScreen(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/splash.json',
              frameRate: const FrameRate(200),
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                RotateAnimatedText(
                  'WELCOME',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Horizon',
                    fontSize: 32.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
