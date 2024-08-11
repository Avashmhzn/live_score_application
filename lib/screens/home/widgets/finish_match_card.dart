import 'package:flutter/material.dart';
import 'package:live_score_application/routes/app_route.dart';
import 'package:live_score_application/screens/home/model/livematch.dart';

class LiveMatchCard extends StatelessWidget {
  final LiveMatch match;

  LiveMatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoute().navigateToDetails(context, match);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(match.leagueLogo),
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.9),
              BlendMode.srcATop,
            ),
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      match.league,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 4),
                        Text(
                          match.matchStatus,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(match.homeLogo, width: 50),
                            const SizedBox(height: 8),
                            Text(
                              match.homeTeam,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                            const Text(
                              'Home',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              match.score,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              match.matchStatus,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(match.awayLogo, width: 50),
                            const SizedBox(height: 8),
                            Text(
                              match.awayTeam,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                            const Text(
                              'Away',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

