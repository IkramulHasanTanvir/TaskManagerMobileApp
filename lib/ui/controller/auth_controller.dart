import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_mobile_app/ui/data/models/user_model.dart';

class AuthController {
  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';
  static const String _profileImageKey = 'profile-image';

  static String? accessToken;
  static UserModel? userData;
  static String? profileImage;

  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<void> saveUserData(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(userModel.toJson()));
    userData = userModel;
  }

  static Future<void> saveProfileImage(List<int> imageBytes) async {
    String base64Image = base64Encode(imageBytes);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_profileImageKey, base64Image);
    profileImage = base64Image;
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    accessToken = token;
    return token;
  }

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

  static Future<List<int>?> getProfileImage() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? image = sharedPreferences.getString(_profileImageKey);
    if(image == null){
      return null;
    }
    List<int> imageBytes = base64Decode(image);
    profileImage = image;
    return imageBytes;

  }

  static bool isLoggedIn() {
    return accessToken != null;
  }

  static Future<void> clearAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_accessTokenKey);
    await sharedPreferences.remove(_userDataKey);
    accessToken = null;
    userData = null;
  }
}
