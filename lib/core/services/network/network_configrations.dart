class NetworkConfigurations {
  static const kRegister = 'user/register';
  static const kLogin = 'user/login';

  static const String BaseUrl = "http://192.168.43.85:8000/api/";
  static const Map<String, String> BaseHeaders = {
    "accept": "application/json, */* ,charset=UTF-8",
    'Charset': 'utf-8'
  };
}
