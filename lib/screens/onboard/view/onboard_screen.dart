import 'package:flutter/material.dart';
import 'package:live_score_application/routes/app_route.dart';

class OnboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Image.asset(
              'assets/image/b.jpg',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              bottom: 60,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  const Text(
                    'Realtime Score Full\nMatch Schedule',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Get live scores and detailed match schedules for all your favorite football games. Stay updated with real-time updates and never miss a moment of the action.',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Urbanist',
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                      /*AppRoute().navigateToDashboardScreen(context);*/
                      AppRoute().navigateToLoginScreen(context);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green.withOpacity(0.7),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              )
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.asset(
                  'assets/image/cr7.jpg',
                  height: 520,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
