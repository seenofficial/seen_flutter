class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "https://rough-mira-seen-app-f74aa423.koyeb.app/api/";
  static const String apartments= "${baseUrl}apartments/";

  static const String login= "${baseUrl}auth/login/";
  static const String signUp= "${baseUrl}auth/register/";

  static const String sendOTP= "${baseUrl}auth/send-otp/";
  static const String verifyOTP= "${baseUrl}auth/verify-otp/";


}
