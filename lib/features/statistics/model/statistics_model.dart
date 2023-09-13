class StatisticsModel {
  int? id;
  String? image;
  String? name;
  String? views;

  StatisticsModel({
    this.id,
    this.name,
    this.image,
    this.views,
  });

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['views'] = views;
    return data;
  }
}
