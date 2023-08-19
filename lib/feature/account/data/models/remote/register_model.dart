class RegisterParamsModel {
  final String name;
  final String email;
  final String password;
  final String number;

  RegisterParamsModel({
    required this.number,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['number'] = number;

    return data;
  }
}

class RegisterResponseModel {
  String? message;
  String? accessToken;
  int? id;

  RegisterResponseModel({this.message, this.accessToken, this.id});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['access_token'];
    id = json['user']['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['access_token'] = accessToken;
    data['id'] = id;

    return data;
  }
}
