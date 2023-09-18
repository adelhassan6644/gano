class AdsModel {
  int? id;
  String? category;
  String? description;
  String? videoLink;
  String? duration;
  String? coins;
  String? image;

  AdsModel({
    this.id,
    this.category,
    this.videoLink,
    this.duration,
    this.description,
    this.coins,
    this.image,
  });

  AdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    videoLink = json['videoLink'].toString();
    description = json['description'].toString();
    coins = json['coins'].toString();
    duration = json['duration'].toString();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['description'] = description;
    data['videoLink'] = videoLink;
    data['duration'] = duration;
    data['coins'] = coins;
    data['image'] = image;
    return data;
  }
}
