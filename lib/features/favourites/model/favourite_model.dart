class FavouriteModel {
  String? message;
  List<FavouriteItem>? data;

  FavouriteModel({this.message, this.data});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(FavouriteItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v).toList();
    }
    return data;
  }
}

class FavouriteItem {
  int? id;
  String? title;
  String? description;
  String? image;

  FavouriteItem({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  FavouriteItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
