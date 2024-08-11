import 'package:live_score_application/services/api_services.dart';
import 'package:live_score_application/services/api_url.dart';

class MatchDetailController{
  Future<List<dynamic>> fetchMatchEvents(String from, String to, String leagueId) async {
    try {
      String url = ApiUrl.eventsUrl(from: from, to: to, leagueId: leagueId);
      var response = await ApiService().get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to load data');
    }
  }

}