class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? invitationCode;
  String? code;
  String? blockedReason;
  String? coins;
  String? views;
  String? points;
  String? weekPoints;
  String? viewsThisWeek;
  String? coinsThisMonth;
  String? coinsThisWeek;
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
      this.code,
      this.coinsThisMonth,
      this.coinsThisWeek,
      this.viewsThisWeek,
      this.createdAt});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        code: json["code"],
        invitationCode: json["invitation_code"] ?? "000",
        blockedReason: json["blocked_reason"],
        points: json['points'] != null ? json['points'].toString() : "0",
        weekPoints:
            json['week_points'] != null ? json['week_points'].toString() : "0",
    viewsThisWeek:
            json['views_this_week'] != null ? json['views_this_week'].toString() : "0",
    coinsThisMonth:
            json['coins_this_week'] != null ? json['coins_this_week'].toString() : "0",
        coinsThisWeek:  json['coins_this_month'] != null ? json['coins_this_month'].toString() : "0",
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
