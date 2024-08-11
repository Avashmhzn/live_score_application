import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_score_application/screens/home/model/team_model.dart';

class AllScreen extends StatelessWidget {
  final MatchesModel matchesModel;

  const AllScreen({Key? key, required this.matchesModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map<String, List<FirstTeamVSSecondTeam>> groupedMatches = {};
    matchesModel.firstTeamVSSecondTeam?.forEach((match) {
      String dateKey = match.matchDate ?? 'Unknown Date';
      if (groupedMatches.containsKey(dateKey)) {
        groupedMatches[dateKey]!.add(match);
      } else {
        groupedMatches[dateKey] = [match];
      }
    });

    List<String> dates = groupedMatches.keys.toList();
    dates.sort((a, b) => DateTime.parse(a).compareTo(DateTime.parse(b)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Matches',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: dates.length,
        itemBuilder: (context, index) {
          String date = dates[index];
          List<FirstTeamVSSecondTeam> matches = groupedMatches[date] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat('dd MMM yyyy').format(DateTime.parse(date)),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                match.teamHomeBadge ?? '',
                                width: 24,
                                height: 24,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image_not_supported, size: 24, color: Colors.white);
                                },
                              ),
                              const SizedBox(width: 8),
                              Text(
                                match.matchHometeamName ?? 'Unknown Team',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                match.matchTime ?? 'Unknown Time',
                                style: const TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                match.matchAwayteamName ?? 'Unknown Team',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Image.network(
                                match.teamAwayBadge ?? '',
                                width: 24,
                                height: 24,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image_not_supported, size: 24, color: Colors.white);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Divider(color: Colors.black),
            ],
          );
        },
      ),
    );
  }
}
