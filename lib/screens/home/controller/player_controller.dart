/*
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:live_score_application/screens/home/model/TopPlayerModel.dart';
import 'package:live_score_application/services/api_url.dart';

class PlayerRankController {
  final Dio _dio = Dio();

  List<TopPlayerModel> players = [];
  bool isLoading = true;
  String errorMessage = '';

  void fetchPlayers(VoidCallback onUpdate) async {
    isLoading = true;
    onUpdate();
    try {
      String url = ApiUrl.topScorersUrl(leagueId: 152);

      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        players = responseData.map((json) => TopPlayerModel.fromJson(json)).toList();
        errorMessage = '';
      } else {
        errorMessage = 'Failed to load players: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = 'Error fetching players: $e';
    }
    isLoading = false;
    onUpdate();
  }
}
*/


import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:live_score_application/screens/home/model/TopPlayerModel.dart';
import 'package:live_score_application/services/api_url.dart';

class PlayerRankController {
  final Dio _dio = Dio();

  List<TopPlayerModel> players = [];
  bool isLoading = true;
  String errorMessage = '';

  void fetchPlayers(VoidCallback onUpdate) async {
    isLoading = true;
    onUpdate();
    try {
      String url = ApiUrl.topScorersUrl(leagueId: 152);

      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        players = responseData.map((json) => TopPlayerModel.fromJson(json)).toList();

        for (var player in players) {
          await fetchPlayerImage(player);
        }

        errorMessage = '';
      } else {
        errorMessage = 'Failed to load players: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = 'Error fetching players: $e';
    }
    isLoading = false;
    onUpdate();
  }

  Future<void> fetchPlayerImage(TopPlayerModel player) async {
    try {
      String url = 'https://apiv3.apifootball.com/?action=get_players&player_id=${player.playerKey}&APIkey=81a66cc521b3f0d65452dc109ef256a039ba2f4094e03424b4d67339c3119640';
      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        if (responseData.isNotEmpty) {
          player.imageUrl = responseData[0]['player_image'];
        }
      }
    } catch (e) {
      print('Error fetching player image: $e');
    }
  }
}
