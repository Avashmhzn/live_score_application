class MatchModel {
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
  String? matchAwayteamName;
  String? matchAwayteamId;
  String? matchAwayteamScore;
  String? matchHometeamHalftimeScore;
  String? matchAwayteamHalftimeScore;
  String? matchHometeamExtraScore;
  String? matchAwayteamExtraScore;
  String? matchHometeamPenaltyScore;
  String? matchAwayteamPenaltyScore;
  String? matchHometeamFtScore;
  String? matchAwayteamFtScore;
  String? matchHometeamSystem;
  String? matchAwayteamSystem;
  String? matchLive;
  String? matchRound;
  String? matchStadium;
  String? matchReferee;
  String? teamHomeBadge;
  String? teamAwayBadge;
  String? leagueLogo;
  String? countryLogo;
  String? leagueYear;
  String? fkStageKey;
  String? stageName;
  List<Goalscorer>? goalscorer;
  List<Cards>? cards;
  Substitutions? substitutions;
  Lineup? lineup;
  List<Statistics>? statistics;

  MatchModel(
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
        this.matchAwayteamName,
        this.matchAwayteamId,
        this.matchAwayteamScore,
        this.matchHometeamHalftimeScore,
        this.matchAwayteamHalftimeScore,
        this.matchHometeamExtraScore,
        this.matchAwayteamExtraScore,
        this.matchHometeamPenaltyScore,
        this.matchAwayteamPenaltyScore,
        this.matchHometeamFtScore,
        this.matchAwayteamFtScore,
        this.matchHometeamSystem,
        this.matchAwayteamSystem,
        this.matchLive,
        this.matchRound,
        this.matchStadium,
        this.matchReferee,
        this.teamHomeBadge,
        this.teamAwayBadge,
        this.leagueLogo,
        this.countryLogo,
        this.leagueYear,
        this.fkStageKey,
        this.stageName,
        this.goalscorer,
        this.cards,
        this.substitutions,
        this.lineup,
        this.statistics,
        });

  MatchModel.fromJson(Map<String, dynamic> json) {
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
    matchAwayteamName = json['match_awayteam_name'];
    matchAwayteamId = json['match_awayteam_id'];
    matchAwayteamScore = json['match_awayteam_score'];
    matchHometeamHalftimeScore = json['match_hometeam_halftime_score'];
    matchAwayteamHalftimeScore = json['match_awayteam_halftime_score'];
    matchHometeamExtraScore = json['match_hometeam_extra_score'];
    matchAwayteamExtraScore = json['match_awayteam_extra_score'];
    matchHometeamPenaltyScore = json['match_hometeam_penalty_score'];
    matchAwayteamPenaltyScore = json['match_awayteam_penalty_score'];
    matchHometeamFtScore = json['match_hometeam_ft_score'];
    matchAwayteamFtScore = json['match_awayteam_ft_score'];
    matchHometeamSystem = json['match_hometeam_system'];
    matchAwayteamSystem = json['match_awayteam_system'];
    matchLive = json['match_live'];
    matchRound = json['match_round'];
    matchStadium = json['match_stadium'];
    matchReferee = json['match_referee'];
    teamHomeBadge = json['team_home_badge'];
    teamAwayBadge = json['team_away_badge'];
    leagueLogo = json['league_logo'];
    countryLogo = json['country_logo'];
    leagueYear = json['league_year'];
    fkStageKey = json['fk_stage_key'];
    stageName = json['stage_name'];
    if (json['goalscorer'] != null) {
      goalscorer = <Goalscorer>[];
      json['goalscorer'].forEach((v) {
        goalscorer!.add(new Goalscorer.fromJson(v));
      });
    }
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(new Cards.fromJson(v));
      });
    }
    substitutions = json['substitutions'] != null
        ? new Substitutions.fromJson(json['substitutions'])
        : null;
    lineup =
    json['lineup'] != null ? new Lineup.fromJson(json['lineup']) : null;
    if (json['statistics'] != null) {
      statistics = <Statistics>[];
      json['statistics'].forEach((v) {
        statistics!.add(new Statistics.fromJson(v));
      });
    }

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
    data['match_awayteam_name'] = this.matchAwayteamName;
    data['match_awayteam_id'] = this.matchAwayteamId;
    data['match_awayteam_score'] = this.matchAwayteamScore;
    data['match_hometeam_halftime_score'] = this.matchHometeamHalftimeScore;
    data['match_awayteam_halftime_score'] = this.matchAwayteamHalftimeScore;
    data['match_hometeam_extra_score'] = this.matchHometeamExtraScore;
    data['match_awayteam_extra_score'] = this.matchAwayteamExtraScore;
    data['match_hometeam_penalty_score'] = this.matchHometeamPenaltyScore;
    data['match_awayteam_penalty_score'] = this.matchAwayteamPenaltyScore;
    data['match_hometeam_ft_score'] = this.matchHometeamFtScore;
    data['match_awayteam_ft_score'] = this.matchAwayteamFtScore;
    data['match_hometeam_system'] = this.matchHometeamSystem;
    data['match_awayteam_system'] = this.matchAwayteamSystem;
    data['match_live'] = this.matchLive;
    data['match_round'] = this.matchRound;
    data['match_stadium'] = this.matchStadium;
    data['match_referee'] = this.matchReferee;
    data['team_home_badge'] = this.teamHomeBadge;
    data['team_away_badge'] = this.teamAwayBadge;
    data['league_logo'] = this.leagueLogo;
    data['country_logo'] = this.countryLogo;
    data['league_year'] = this.leagueYear;
    data['fk_stage_key'] = this.fkStageKey;
    data['stage_name'] = this.stageName;
    if (this.goalscorer != null) {
      data['goalscorer'] = this.goalscorer!.map((v) => v.toJson()).toList();
    }
    if (this.cards != null) {
      data['cards'] = this.cards!.map((v) => v.toJson()).toList();
    }
    if (this.substitutions != null) {
      data['substitutions'] = this.substitutions!.toJson();
    }
    if (this.lineup != null) {
      data['lineup'] = this.lineup!.toJson();
    }
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Goalscorer {
  String? time;
  String? homeScorer;
  String? homeScorerId;
  String? homeAssist;
  String? homeAssistId;
  String? score;
  String? awayScorer;
  String? awayScorerId;
  String? awayAssist;
  String? awayAssistId;
  String? info;
  String? scoreInfoTime;

  Goalscorer(
      {this.time,
        this.homeScorer,
        this.homeScorerId,
        this.homeAssist,
        this.homeAssistId,
        this.score,
        this.awayScorer,
        this.awayScorerId,
        this.awayAssist,
        this.awayAssistId,
        this.info,
        this.scoreInfoTime});

  Goalscorer.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    homeScorer = json['home_scorer'];
    homeScorerId = json['home_scorer_id'];
    homeAssist = json['home_assist'];
    homeAssistId = json['home_assist_id'];
    score = json['score'];
    awayScorer = json['away_scorer'];
    awayScorerId = json['away_scorer_id'];
    awayAssist = json['away_assist'];
    awayAssistId = json['away_assist_id'];
    info = json['info'];
    scoreInfoTime = json['score_info_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['home_scorer'] = this.homeScorer;
    data['home_scorer_id'] = this.homeScorerId;
    data['home_assist'] = this.homeAssist;
    data['home_assist_id'] = this.homeAssistId;
    data['score'] = this.score;
    data['away_scorer'] = this.awayScorer;
    data['away_scorer_id'] = this.awayScorerId;
    data['away_assist'] = this.awayAssist;
    data['away_assist_id'] = this.awayAssistId;
    data['info'] = this.info;
    data['score_info_time'] = this.scoreInfoTime;
    return data;
  }
}

class Cards {
  String? time;
  String? homeFault;
  String? card;
  String? awayFault;
  String? info;
  String? homePlayerId;
  String? awayPlayerId;
  String? scoreInfoTime;

  Cards(
      {this.time,
        this.homeFault,
        this.card,
        this.awayFault,
        this.info,
        this.homePlayerId,
        this.awayPlayerId,
        this.scoreInfoTime});

  Cards.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    homeFault = json['home_fault'];
    card = json['card'];
    awayFault = json['away_fault'];
    info = json['info'];
    homePlayerId = json['home_player_id'];
    awayPlayerId = json['away_player_id'];
    scoreInfoTime = json['score_info_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['home_fault'] = this.homeFault;
    data['card'] = this.card;
    data['away_fault'] = this.awayFault;
    data['info'] = this.info;
    data['home_player_id'] = this.homePlayerId;
    data['away_player_id'] = this.awayPlayerId;
    data['score_info_time'] = this.scoreInfoTime;
    return data;
  }
}

class Substitutions {
  List<Home>? home;
  List<Home>? away;

  Substitutions({this.home, this.away});

  Substitutions.fromJson(Map<String, dynamic> json) {
    if (json['home'] != null) {
      home = <Home>[];
      json['home'].forEach((v) {
        home!.add(new Home.fromJson(v));
      });
    }
    if (json['away'] != null) {
      away = <Home>[];
      json['away'].forEach((v) {
        away!.add(new Home.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.home != null) {
      data['home'] = this.home!.map((v) => v.toJson()).toList();
    }
    if (this.away != null) {
      data['away'] = this.away!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/*class Home {
  String? time;
  String? substitution;
  String? substitutionPlayerId;

  Home({this.time, this.substitution, this.substitutionPlayerId});

  Home.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    substitution = json['substitution'];
    substitutionPlayerId = json['substitution_player_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['substitution'] = this.substitution;
    data['substitution_player_id'] = this.substitutionPlayerId;
    return data;
  }
}*/

class Home {
  List<StartingLineups>? startingLineups; // Corrected field name

  Home({this.startingLineups});

  Home.fromJson(Map<String, dynamic> json) {
    if (json['starting_lineups'] != null) {
      startingLineups = <StartingLineups>[];
      json['starting_lineups'].forEach((v) {
        startingLineups!.add(StartingLineups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (startingLineups != null) {
      data['starting_lineups'] = startingLineups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Lineup {
  Home? home;
  Home? away;

  Lineup({this.home, this.away});

  Lineup.fromJson(Map<String, dynamic> json) {
    home = json['home'] != null ? new Home.fromJson(json['home']) : null;
    away = json['away'] != null ? new Home.fromJson(json['away']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.home != null) {
      data['home'] = this.home!.toJson();
    }
    if (this.away != null) {
      data['away'] = this.away!.toJson();
    }
    return data;
  }
}


class StartingLineups {
  String? lineupPlayer;
  String? lineupNumber;
  String? lineupPosition;
  String? playerKey;

  StartingLineups(
      {this.lineupPlayer,
        this.lineupNumber,
        this.lineupPosition,
        this.playerKey});

  StartingLineups.fromJson(Map<String, dynamic> json) {
    lineupPlayer = json['lineup_player'];
    lineupNumber = json['lineup_number'];
    lineupPosition = json['lineup_position'];
    playerKey = json['player_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lineup_player'] = this.lineupPlayer;
    data['lineup_number'] = this.lineupNumber;
    data['lineup_position'] = this.lineupPosition;
    data['player_key'] = this.playerKey;
    return data;
  }
}

class Statistics {
  String? type;
  String? home;
  String? away;

  Statistics({this.type, this.home, this.away});

  Statistics.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['home'] = this.home;
    data['away'] = this.away;
    return data;
  }
}
