import 'package:flutter/material.dart';
import 'package:live_score_application/screens/home/model/team_model.dart';

class MatchCard extends StatelessWidget {
  final FirstTeamVSSecondTeam match;

  MatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
        image: match.leagueLogo != null
            ? DecorationImage(
          image: NetworkImage(match.leagueLogo!),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.blue.withOpacity(0.9),
            BlendMode.srcATop,
          ),
        )
            : null,
      ),
      child: match.matchDate != null
          ? Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    match.leagueName ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    match.matchDate ?? 'Date',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    match.teamHomeBadge != null
                        ? Image.network(match.teamHomeBadge!, width: 60)
                        : Container(width: 40, height: 40),
                    const SizedBox(height: 8),
                    Text(
                      match.matchHometeamName ?? 'Home Team',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                    const Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'V/S',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    match.teamAwayBadge != null
                        ? Image.network(match.teamAwayBadge!, width: 60)
                        : Container(width: 40, height: 40),
                    const SizedBox(height: 8),
                    Text(
                      match.matchAwayteamName ?? 'Away Team',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                    const Text(
                      'Away',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
