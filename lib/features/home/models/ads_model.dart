class AdsModel {
  int? id;
  String? category;
  String? duration;
  String? coins;
  String? image;

  AdsModel({
    this.id,
    this.category,
    this.duration,
    this.coins,
    this.image,
  });

  AdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    duration = json['duration'].toString();
    coins = json['coins'].toString();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['duration'] = duration;
    data['coins'] = coins;
    data['image'] = image;
    return data;
  }
}
