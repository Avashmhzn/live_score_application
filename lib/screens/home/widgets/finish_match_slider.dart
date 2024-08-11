import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:live_score_application/screens/home/model/livematch.dart';
import 'package:live_score_application/screens/home/widgets/finish_match_card.dart';
import 'package:live_score_application/screens/home/widgets/finish_match_skeletion.dart';
import 'package:live_score_application/services/api_services.dart';
import 'package:live_score_application/services/api_url.dart';

class LiveMatchesSlider extends StatefulWidget {
  final PageController controller;

  LiveMatchesSlider({super.key, required this.controller});

  @override
  _LiveMatchesSliderState createState() => _LiveMatchesSliderState();
}

class _LiveMatchesSliderState extends State<LiveMatchesSlider> {
  List<LiveMatch> matches = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchLiveMatches();
  }

  void fetchLiveMatches() async {
    print('Fetching live matches');
    setState(() {
      isLoading = true;
    });
    final url = ApiUrl.eventsUrl(from: '2023-04-05', to: '2023-04-05', leagueId: '152');

    try {
      final Response response = await ApiService().get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data.containsKey('error')) {
          print('Error fetching live matches: ${data['message']}');
          return;
        }
        if (data is List) {
          setState(() {
            matches = data.map((json) => LiveMatch.fromJson(json)).toList();
          });
          for (var match in matches) {
            print('Match: ${match.homeTeam} vs ${match.awayTeam}, Score: ${match.score}');
          }
        } else {
          print('Error fetching live matches: Unexpected response format.');
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching live matches: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? FinishedMatchSkeleton()
        : matches.isEmpty
        ? const Center(child: Text('No live matches', style: TextStyle(color: Colors.white)))
        : SizedBox(
      height: 200,
      child: PageView.builder(
        controller: widget.controller,
        itemCount: matches.length,
        itemBuilder: (context, index) {
          return LiveMatchCard(match: matches[index]);
        },
      ),
    );
  }
}
