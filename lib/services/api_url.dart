/*
class ApiUrl{
  static const String apiKey = '04bf745e1a7d40228cfb57080af391bc';
  static const String baseUrl = 'https://api.sportsdata.io/v4/soccer/';

  static const String competitions = '/Competitions';
  static String boxScore({required String competition,required String gameid}) => 'stats/json/BoxScore/$competition/$gameid';
}
*/
class ApiUrl {
  static const String apiKey = '4299ca9e75b475ebee3312c3bf3e6a6195b4518a2ae361e1a8be4c97a60b2a0e';
  static const String baseUrl = 'https://apiv3.apifootball.com/';

  static String eventsUrl({required String from, required String to, required String leagueId}) {
    return '?action=get_events&from=$from&to=$to&league_id=$leagueId';
  }

  static String getH2HUrl({required String firstTeamId, required String secondTeamId}) {
    return '$baseUrl?action=get_H2H&firstTeamId=$firstTeamId&secondTeamId=$secondTeamId&APIkey=$apiKey';
  }
  static String topScorersUrl({required int leagueId}) {
    return '$baseUrl?action=get_topscorers&league_id=$leagueId&APIkey=$apiKey';
  }

  static String playerdetails({required int leagueId}) {
    return '$baseUrl?action=get_topscorers&league_id=$leagueId&APIkey=$apiKey';
  }
}
