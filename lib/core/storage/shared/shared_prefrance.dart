import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static const localization = "localization";
  static const loginInApp = "skipOnboarding";
  static const kFcmToken = "fcmKey";

  static Future saveFcm(String fcm) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(kFcmToken, fcm);
  }

  static Future<String> getFcm() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(kFcmToken) ?? "";
  }

  static Future<bool> getOnBoarding() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bool? result = sharedPreferences.getBool(loginInApp);
    return result ?? false;
  }

  static Future saveOnBoarding(bool onBoarding) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(loginInApp, onBoarding);
  }
}
