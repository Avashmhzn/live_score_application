class TopPlayerModel {
  String? playerPlace;
  String? playerName;
  int? playerKey;
  String? teamName;
  String? teamKey;
  int? goals;
  int? assists;
  int? penaltyGoals;
  String? fkStageKey;
  String? stageName;
  String? imageUrl;

  TopPlayerModel({
    this.playerPlace,
    this.playerName,
    this.playerKey,
    this.teamName,
    this.teamKey,
    this.goals,
    this.assists,
    this.penaltyGoals,
    this.fkStageKey,
    this.stageName,
    this.imageUrl,
  });

  factory TopPlayerModel.fromJson(Map<String, dynamic> json) {
    return TopPlayerModel(
      playerPlace: json['player_place'],
      playerName: json['player_name'],
      playerKey: json['player_key'],
      teamName: json['team_name'],
      teamKey: json['team_key'],
      goals: json['goals'] != null ? int.tryParse(json['goals']) ?? 0 : 0,
      assists: json['assists'] != null ? int.tryParse(json['assists']) ?? 0 : 0,
      penaltyGoals: json['penalty_goals'] != null ? int.tryParse(json['penalty_goals']) ?? 0 : 0,
      fkStageKey: json['fk_stage_key'],
      stageName: json['stage_name'],
      imageUrl: json['player_image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_place'] = this.playerPlace;
    data['player_name'] = this.playerName;
    data['player_key'] = this.playerKey;
    data['team_name'] = this.teamName;
    data['team_key'] = this.teamKey;
    data['goals'] = this.goals.toString();
    data['assists'] = this.assists.toString();
    data['penalty_goals'] = this.penaltyGoals.toString();
    data['fk_stage_key'] = this.fkStageKey;
    data['stage_name'] = this.stageName;
    data['player_image'] = this.imageUrl;
    return data;
  }
}
