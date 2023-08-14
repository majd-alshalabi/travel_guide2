class NetworkConfigurations {
  static const kRegister = 'user/register';
  static const kGetAllActivity = 'getactivity';
  static const kGetTopRatedActivity = 'toprated';
  static const kRateActivity = 'addrate';
  static const kRateGuide = 'rateaguide';
  static const kToggleBookMark = 'addbookamrk';
  static const kGetBookMarked = 'bookmarked';
  static const kGetNearbyLocation = 'nearbylocation';
  static const kGetTopGuide = 'topguides';
  static const kAddComment = 'comment';
  static const kLogin = 'user/login';
  static const kChangePassword = 'change_password';

  static const String BaseUrl = "http://192.168.43.85:8000/api/";
  static const Map<String, String> BaseHeaders = {
    "accept": "application/json, */* ,charset=UTF-8",
    'Charset': 'utf-8'
  };
}
