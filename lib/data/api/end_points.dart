class EndPoints {
  static const String baseUrl = 'https://gano.softwarecloud2.com/api/';
  static const String googleMapsBaseUrl = 'https://maps.googleapis.com';
  static const String imageUrl = 'https://massage-app.softwarecloud2.com/';
  static const String apiKey = 's7xrpFdw4G0F21rfLyD4TaBkjVJYgwGfI3y458ejWjw9zOggruX30e1as2d3';
  static const String topic = 'gano';
  static const String logIn = 'v1/login';
  static const String register = 'client';
  static const String forgetPassword = 'resetPassword/email';
  static const String checkMailForResetPassword = 'resetPassword/checkCode';
  static const String resetPassword = 'resetPassword/newPassword';
  static changePassword(id) => 'changePassword/$id';
  static const String resend = 'email/verification';
  static const String verifyEmail = 'check/verificationCode';
  static getProfile(id) => 'client/$id';
  static updateProfile(id) => 'client/$id';
  static getFavourites(id) => 'favorites/$id';
  static getNotifications(id) => 'notification/$id';
  static readNotification(userId, id) => 'notification/read/$userId/$id';
  static deleteNotification(userId, id) => 'notification/delete/$userId/$id';
  static getAddresses(id) => 'address/$id';
  static deleteAddress(id) => 'address/$id';
  static String addAddress = 'address';
  static cancelReservation(id) => 'reservation/$id';
  static nextReservations(id) => 'next/reservation/$id';
  static previousReservations(id) => 'past/reservation/$id';
  static const String postFavourite = 'favorite';
  static const String category = 'service';
  static const products = 'subService';
  static categoryProducts(id) => 'service/$id';
  static const String banners = 'banner';
  static productDetails(id) => 'subService/$id';
  static productSchedule(id) => 'subService/schedule/$id';
  static daySchedule(id) => 'subService/daySchedule/$id';
  static payment(id) => '/$id';
  static const String ratting = 'feedback';
  static const String checkOut = 'setting';
  static const String setting = 'setting';
  static contact(id) => 'contact/$id';
  static invitation(id) => 'contact/$id';

  /// maps
  static const String GEOCODE_URI = '/maps/api/geocode/';
  static const String Autocomplete = '/maps/api/place/autocomplete/';
//https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
//'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=n,&key=AIzaSyB_l2x6zgnLTF4MKxX3S4Df9urLN6vLNP0
}
