import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  static const String _keyUserName = 'full_name';
  static const String _keyUserPhoneNumber = 'phoneNumber';
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyLanguage = 'language';

  // Singleton instance
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();
  factory SharedPreferencesService() => _instance;
  SharedPreferencesService._internal();

  // SharedPreferences instance
  late SharedPreferences _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }



  // User Name
  String get userName => _prefs.getString(_keyUserName) ?? '';
  Future<void> setUserName(String value) async => await _prefs.setString(_keyUserName, value);

  // userPhone
  String get userPhone => _prefs.getString(_keyUserPhoneNumber) ?? '';
  Future<void> setUserPhone(String value) async => await _prefs.setString(_keyUserPhoneNumber, value);

  // Access Token
  String get accessToken => _prefs.getString(_keyAccessToken) ?? '';
  Future<void> setAccessToken(String value) async => await _prefs.setString(_keyAccessToken, value);

  // Refresh Token
  String get refreshToken => _prefs.getString(_keyRefreshToken) ?? '';
  Future<void> setRefreshToken(String value) async => await _prefs.setString(_keyRefreshToken, value);

  // Language
  String get language => _prefs.getString(_keyLanguage) ?? '';
  Future<void> setLanguage(String value) async => await _prefs.setString(_keyLanguage, value);

  Future<void> storeValue(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      throw ArgumentError('Unsupported value type: ${value.runtimeType}');
    }
  }

  dynamic getValue(String key, {dynamic defaultValue}) {
    if (_prefs.containsKey(key)) {
      return _prefs.get(key);
    }
    return defaultValue;
  }

  bool hasKey(String key) => _prefs.containsKey(key);

  Future<void> clearAllData() async => await _prefs.clear();
}