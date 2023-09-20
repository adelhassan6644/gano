class EndPoints {
  static const String baseUrl = 'https://gano.softwarecloud2.com/api/';
  static const String googleMapsBaseUrl = 'https://maps.googleapis.com';
  static const String imageUrl = 'https://gano.softwarecloud2.com/';
  static const String apiKey =
      's7xrpFdw4G0F21rfLyD4TaBkjVJYgwGfI3y458ejWjw9zOggruX30e1as2d3';

  ///Authentication
  static const String topic = 'gano';
  static const String logIn = 'login';
  static const String register = 'client';
  static const String forgetPassword = 'resetPassword/email';
  static const String checkMailForResetPassword = 'resetPassword/checkCode';
  static const String resetPassword = 'resetPassword/newPassword';
  static changePassword(id) => 'changePassword/$id';
  static const String resend = 'email/verification';
  static const String verifyEmail = 'check/verificationCode';

  /// Profile and Favourites
  static getProfile(id) => 'client/$id';
  static updateProfile(id) => 'client/$id';
  static const String categories = 'category';
  static updateFavourite(id) => 'add/categories/$id';
  static getFavourites(id) => 'client/categories/$id';

  ///Profile Statistics
  static getStatistics(id) => 'statistics/$id';

  ///Monthly Statistics
  static monthlyStatistics(id) => 'top/clients/views/$id';

  ///Notifications
  static getNotifications(id) => 'notification/$id';
  static readNotification(userId, id) => 'notification/read/$userId/$id';
  static deleteNotification(userId, id) => 'notification/delete/$userId/$id';
  static previousReservations(id) => 'past/reservation/$id';

  static const String banners = 'banner';
  static const String videos = 'video';
  static relatedVideos(id) => 'related/videos/$id';
  static const String viewVideo = 'view/video';
  static const String setting = 'setting';
  static contact(id) => 'contact/$id';
  static invitation(id) => 'contact/$id';

  /// maps
  static const String GEOCODE_URI = '/maps/api/geocode/';
  static const String Autocomplete = '/maps/api/place/autocomplete/';
//https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
//'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=n,&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
}
