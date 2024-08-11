class MatchesModel {
  List<FirstTeamVSSecondTeam>? firstTeamVSSecondTeam;
  List<FirstTeamVSSecondTeam>? firstTeamLastResults;
  List<FirstTeamVSSecondTeam>? secondTeamLastResults;

  MatchesModel(
      {this.firstTeamVSSecondTeam,
        this.firstTeamLastResults,
        this.secondTeamLastResults});

  MatchesModel.fromJson(Map<String, dynamic> json) {
    if (json['firstTeam_VS_secondTeam'] != null) {
      firstTeamVSSecondTeam = <FirstTeamVSSecondTeam>[];
      json['firstTeam_VS_secondTeam'].forEach((v) {
        firstTeamVSSecondTeam!.add(new FirstTeamVSSecondTeam.fromJson(v));
      });
    }
    if (json['firstTeam_lastResults'] != null) {
      firstTeamLastResults = <FirstTeamVSSecondTeam>[];
      json['firstTeam_lastResults'].forEach((v) {
        firstTeamLastResults!.add(new FirstTeamVSSecondTeam.fromJson(v));
      });
    }
    if (json['secondTeam_lastResults'] != null) {
      secondTeamLastResults = <FirstTeamVSSecondTeam>[];
      json['secondTeam_lastResults'].forEach((v) {
        secondTeamLastResults!.add(new FirstTeamVSSecondTeam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.firstTeamVSSecondTeam != null) {
      data['firstTeam_VS_secondTeam'] =
          this.firstTeamVSSecondTeam!.map((v) => v.toJson()).toList();
    }
    if (this.firstTeamLastResults != null) {
      data['firstTeam_lastResults'] =
          this.firstTeamLastResults!.map((v) => v.toJson()).toList();
    }
    if (this.secondTeamLastResults != null) {
      data['secondTeam_lastResults'] =
          this.secondTeamLastResults!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FirstTeamVSSecondTeam {
  String? matchId;
  String? countryId;
  String? countryName;
  String? leagueId;
  String? leagueName;
  String? matchDate;
  String? matchStatus;
  String? matchTime;
  String? matchHometeamId;
  String? matchHometeamName;
  String? matchHometeamScore;
  String? matchAwayteamId;
  String? matchAwayteamName;
  String? matchAwayteamScore;
  String? matchHometeamHalftimeScore;
  String? matchAwayteamHalftimeScore;
  String? matchLive;
  String? teamHomeBadge;
  String? teamAwayBadge;
  String? leagueLogo;
  String? countryLogo;

  FirstTeamVSSecondTeam(
      {this.matchId,
        this.countryId,
        this.countryName,
        this.leagueId,
        this.leagueName,
        this.matchDate,
        this.matchStatus,
        this.matchTime,
        this.matchHometeamId,
        this.matchHometeamName,
        this.matchHometeamScore,
        this.matchAwayteamId,
        this.matchAwayteamName,
        this.matchAwayteamScore,
        this.matchHometeamHalftimeScore,
        this.matchAwayteamHalftimeScore,
        this.matchLive,
        this.teamHomeBadge,
        this.teamAwayBadge,
        this.leagueLogo,
        this.countryLogo});

  FirstTeamVSSecondTeam.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    leagueId = json['league_id'];
    leagueName = json['league_name'];
    matchDate = json['match_date'];
    matchStatus = json['match_status'];
    matchTime = json['match_time'];
    matchHometeamId = json['match_hometeam_id'];
    matchHometeamName = json['match_hometeam_name'];
    matchHometeamScore = json['match_hometeam_score'];
    matchAwayteamId = json['match_awayteam_id'];
    matchAwayteamName = json['match_awayteam_name'];
    matchAwayteamScore = json['match_awayteam_score'];
    matchHometeamHalftimeScore = json['match_hometeam_halftime_score'];
    matchAwayteamHalftimeScore = json['match_awayteam_halftime_score'];
    matchLive = json['match_live'];
    teamHomeBadge = json['team_home_badge'];
    teamAwayBadge = json['team_away_badge'];
    leagueLogo = json['league_logo'];
    countryLogo = json['country_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    data['league_id'] = this.leagueId;
    data['league_name'] = this.leagueName;
    data['match_date'] = this.matchDate;
    data['match_status'] = this.matchStatus;
    data['match_time'] = this.matchTime;
    data['match_hometeam_id'] = this.matchHometeamId;
    data['match_hometeam_name'] = this.matchHometeamName;
    data['match_hometeam_score'] = this.matchHometeamScore;
    data['match_awayteam_id'] = this.matchAwayteamId;
    data['match_awayteam_name'] = this.matchAwayteamName;
    data['match_awayteam_score'] = this.matchAwayteamScore;
    data['match_hometeam_halftime_score'] = this.matchHometeamHalftimeScore;
    data['match_awayteam_halftime_score'] = this.matchAwayteamHalftimeScore;
    data['match_live'] = this.matchLive;
    data['team_home_badge'] = this.teamHomeBadge;
    data['team_away_badge'] = this.teamAwayBadge;
    data['league_logo'] = this.leagueLogo;
    data['country_logo'] = this.countryLogo;
    return data;
  }
}
