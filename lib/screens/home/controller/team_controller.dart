import 'package:dio/dio.dart';
import 'package:live_score_application/screens/home/model/team_model.dart';
import 'package:live_score_application/services/api_url.dart';

class TeamController {
  MatchesModel? matchesModel;
  final Dio _dio = Dio();


  Future<void> fetchMatches(List<int> homeTeamIds, List<int> awayTeamIds) async {
    List<FirstTeamVSSecondTeam> firstTeamVSSecondTeam = [];
    List<FirstTeamVSSecondTeam> firstTeamLastResults = [];
    List<FirstTeamVSSecondTeam> secondTeamLastResults = [];

    for (int i = 0; i < homeTeamIds.length; i++) {
      for (int j = 0; j < awayTeamIds.length; j++) {
        String url = ApiUrl.getH2HUrl(
            firstTeamId: homeTeamIds[i].toString(),
            secondTeamId: awayTeamIds[j].toString()
        );

        try {
          final response = await _dio.get(url);

          if (response.statusCode == 200) {
            var jsonData = response.data;
            var matches = (jsonData['firstTeam_VS_secondTeam'] as List).map((data) => FirstTeamVSSecondTeam.fromJson(data)).toList();
            firstTeamVSSecondTeam.addAll(matches);

            var firstTeamResults = (jsonData['firstTeam_lastResults'] as List).map((data) => FirstTeamVSSecondTeam.fromJson(data)).toList();
            firstTeamLastResults.addAll(firstTeamResults);

            var secondTeamResults = (jsonData['secondTeam_lastResults'] as List).map((data) => FirstTeamVSSecondTeam.fromJson(data)).toList();
            secondTeamLastResults.addAll(secondTeamResults);
          } else {
            throw Exception('Failed to load matches for team IDs ${homeTeamIds[i]} and ${awayTeamIds[j]}');
          }
        } catch (e) {
          throw Exception('Error fetching matches: $e');
        }
      }
    }

    matchesModel = MatchesModel(
      firstTeamVSSecondTeam: firstTeamVSSecondTeam,
      firstTeamLastResults: firstTeamLastResults,
      secondTeamLastResults: secondTeamLastResults,
    );
  }
}
