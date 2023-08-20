class NetworkConfigurations {
  static const kRegister = 'user/register';
  static const kLogOut = 'logout';
  static const kGetAllActivity = 'getactivity';
  static const kGetAllRegion = 'getregions';
  static const kGetAllGuides = 'get_all_guides';
  static const kGetActivity = 'getactivity';
  static const kGetRegion = 'getregionsincity';
  static const kAddRegion = 'addregion';
  static const kAddActivity = 'addactivity';
  static const kGetAllCity = 'getcities';
  static const kGetTopRatedActivity = 'toprated';
  static const kRateActivity = 'addrate';
  static const kRateGuide = 'rateaguide';
  static const kAddCity = 'addcity';
  static const kToggleBookMark = 'addbookamrk';
  static const kGetBookMarked = 'bookmarked';
  static const kGetNearbyLocation = 'nearbylocation';
  static const kGetTopGuide = 'topguides';
  static const kAddComment = 'comment';
  static const kLogin = 'user/login';
  static const kChangePassword = 'change_password';
  static const kUploadImage = 'for_guide/addimages';
  static const String BaseUrl = "http://192.168.43.85:8000/api/";
  static const Map<String, String> BaseHeaders = {
    "accept": "application/json, */* ,charset=UTF-8",
    'Charset': 'utf-8'
  };
}
