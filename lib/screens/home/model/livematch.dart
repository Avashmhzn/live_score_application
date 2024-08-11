class LiveMatch {
  final String matchId;
  final String homeTeam;
  final String awayTeam;
  final String homeLogo;
  final String awayLogo;
  final String league;
  final String leagueLogo;
  final String matchStatus;
  final String score;
  final String matchNumber;
  final String stadium;
  final String matchDate;

  LiveMatch({
    required this.matchId,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeLogo,
    required this.awayLogo,
    required this.league,
    required this.leagueLogo,
    required this.matchStatus,
    required this.score,
    required this.matchNumber,
    required this.stadium,
    required this.matchDate,

  });

  factory LiveMatch.fromJson(Map<String, dynamic> json) {
    return LiveMatch(
      matchId: json['match_id'].toString(),
      homeTeam: json['match_hometeam_name'],
      awayTeam: json['match_awayteam_name'],
      homeLogo: json['team_home_badge'] ?? '',
      awayLogo: json['team_away_badge'] ?? '',
      league: json['league_name'] ?? '',
      leagueLogo: json['league_logo'] ?? '',
      matchStatus: json['match_status'],
      score: '${json['match_hometeam_score']} - ${json['match_awayteam_score']}',
      matchNumber: json['match_round'].toString(),
      stadium: json['match_stadium'],
      matchDate: json['match_date'].toString(),
    );
  }
}

