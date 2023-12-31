class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? invitationCode;
  String? blockedReason;
  String? coins;
  String? views;
  String? points;
  String? weekPoints;
  DateTime? createdAt;

  ProfileModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.invitationCode,
      this.blockedReason,
      this.points,
      this.weekPoints,
      this.coins,
      this.views,
      this.createdAt});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        invitationCode: json["invitation_code"],
        blockedReason: json["blocked_reason"],
        points: json['points'] != null ? json['points'].toString() : "0",
        weekPoints:
            json['week_points'] != null ? json['week_points'].toString() : "0",
        coins: json['coins'] != null ? json['coins'].toString() : "0",
        views: json['views'] != null ? json['views'].toString() : "0",
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "points": points,
        "week_points": weekPoints,
        "views": views,
        "coins": coins,
        "created_at": createdAt?.toIso8601String(),
      };
}
