class VideoModel {
  int? id;
  String? category;
  String? description;
  String? title;
  String? videoPath;
  String? duration;
  String? coins;
  String? image;

  VideoModel({
    this.id,
    this.category,
    this.title,
    this.videoPath,
    this.duration,
    this.description,
    this.coins,
    this.image,
  });

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    videoPath = json['video_path'];
    duration = json['duration'].toString();
    coins = json['coins'].toString();
    category = json['category'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['title'] = title;
    data['description'] = description;
    data['videoLink'] = videoPath;
    data['duration'] = duration.toString();
    data['coins'] = coins;
    data['image'] = image;
    return data;
  }
}
