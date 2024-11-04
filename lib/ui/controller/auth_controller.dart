import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_mobile_app/ui/data/models/user_model.dart';

class AuthController {
  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  static String? accessToken;
  static UserModel? userData;

  // Save access token in shared preferences and cache it in memory
  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  // Save user data in shared preferences and cache it in memory
  static Future<void> saveUserData(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(userModel.toJson()));
    userData = userModel;
  }

  // Retrieve access token from shared preferences and cache it
  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    accessToken = token;
    return token;
  }

  // Retrieve user data from shared preferences and cache it
  static Future<UserModel?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEncodedData = sharedPreferences.getString(_userDataKey);
    if (userEncodedData == null) {
      return null;
    }
    UserModel userModel = UserModel.fromJson(jsonDecode(userEncodedData));
    userData = userModel;
    return userModel;
  }

  // Check if the user is logged in based on the access token
  static bool isLoggedIn() {
    return accessToken != null;
  }

  // Clear only authentication-related data in shared preferences and memory cache
  static Future<void> clearAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_accessTokenKey);
    await sharedPreferences.remove(_userDataKey);
    accessToken = null;
    userData = null;
  }
}
