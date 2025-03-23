class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "https://rough-mira-seen-app-f74aa423.koyeb.app/api/";
  static const String properties= "${baseUrl}properties/";
  static const String banners= "${baseUrl}banners/";

  static const String apartment= "${baseUrl}apartments/";
  static const String villa= "${baseUrl}villas/";
  static const String building= "${baseUrl}buildings/";
  static const String land= "${baseUrl}lands/";

  static const String login= "${baseUrl}auth/login/";
  static const String signUp= "${baseUrl}auth/register/";

  static const String sendOTP= "${baseUrl}auth/send-otp/";
  static const String verifyOTP= "${baseUrl}auth/verify-otp/";


  /// location

  static const String countries= "${baseUrl}countries/";
  static const String states= "${baseUrl}states/";
  static const String cities= "${baseUrl}cities/";


  static const String wishList= "${baseUrl}users/wish-list/";
  static const String user= "${baseUrl}users/me/";
  static const String propertyBusyDays= "${baseUrl}property-partner-busy-dates";
  static const String propertyOrderDetails= "${baseUrl}property-order-detail";
  static const String amenities= "${baseUrl}amenities";
  static const String preview= "${baseUrl}viewing-requests";
  static const String appointments= "${baseUrl}viewing-requests-list";
  static const String appointmentUpdate= "${baseUrl}viewing-requests";


  static const String deals= "${baseUrl}deals/";
  static const String transactions= "${baseUrl}payments/transactions/";
  static const String contracts= "${baseUrl}contracts";
  static const String contact= "${baseUrl}contact-us/";
  static const String notification= "${baseUrl}notifications/devices/";

}
