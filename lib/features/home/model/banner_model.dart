class BannerModel {
  int? id;
  String? image;
  String? title;
  int? subServiceId;

  BannerModel({
    this.id,
    this.image,
    this.title,
    this.subServiceId,
  });

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    subServiceId =
        json['subservice'] != null && json['subservice']['id'] != null
            ? json['subservice']['id']
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_service_id'] = subServiceId;
    data['image'] = image;
    data['title'] = title;
    return data;
  }
}
