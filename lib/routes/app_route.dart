import 'package:flutter/material.dart';
import 'package:live_score_application/allscreen/all_screen.dart';
import 'package:live_score_application/screens/authentication/login/view/login_screen.dart';
import 'package:live_score_application/screens/authentication/signup/view/signup_screen.dart';
import 'package:live_score_application/screens/dashboard/view/dashboard_screen.dart';
import 'package:live_score_application/screens/home/model/livematch.dart';
import 'package:live_score_application/screens/home/view/home_screen.dart';
import 'package:live_score_application/screens/matchdetail/view/matchdetails.dart';
import 'package:live_score_application/screens/onboard/view/onboard_screen.dart';
import 'package:live_score_application/screens/upload_reel/view/upload_screen.dart';


class AppRoute {
  void navigateToOnboardScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OnboardScreen(),
      ),
    );
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(scrollController: ScrollController()),
      ),
    );
  }

  void navigateToDetails(BuildContext context, LiveMatch match) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchDetailScreen(detail: match),
      ),
    );
  }

  void navigateToDashboardScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }


  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SignupScreen(),
      ),
    );
  }

  void navigateToUploadScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UploadReelScreen(),
      ),
    );
  }

}
