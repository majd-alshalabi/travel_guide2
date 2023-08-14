class ChangePasswordParamsModel {
  final String password;
  final String confirmPassword;

  ChangePasswordParamsModel({
    required this.confirmPassword,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['confirm_password'] = confirmPassword;

    return data;
  }
}

class ChangePasswordResponseModel {
  String? message;

  ChangePasswordResponseModel({this.message});

  ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
