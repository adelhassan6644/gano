class StatisticsModel {
  String? coins;
  String? views;
  String? points;
  String? weekPoints;

  StatisticsModel({
    this.points,
    this.weekPoints,
    this.coins,
    this.views,
  });

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    points = json['points'] != null? json['points'].toString():"0";
    weekPoints = json['week_points'] != null? json['week_points'].toString():"0";
    coins =  json['coins'] != null? json['coins'].toString():"0";
    views = json['views'] != null? json['views'].toString():"0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['points'] = points;
    data['week_points'] = weekPoints;
    data['coins'] = coins;
    data['views'] = views;
    return data;
  }
}
