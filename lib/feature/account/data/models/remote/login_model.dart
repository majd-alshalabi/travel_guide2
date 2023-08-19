class LoginParamsModel {
  final String email;
  final String password;

  LoginParamsModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;

    return data;
  }
}

class LoginResponseModel {
  String? accessToken;
  User? user;
  UserType? type;

  LoginResponseModel({this.accessToken, this.user, this.type});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    type = UserType.formInt(json['type']);
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['type'] = this.type?.toInt();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? number;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.number,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    number = json['number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['number'] = number;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

enum UserType {
  user,
  guide;

  static formInt(int val) {
    if (val == 0)
      return UserType.user;
    else
      return UserType.guide;
  }

  String toString() {
    switch (this) {
      case guide:
        return "guide";
      case user:
        return "user";
    }
  }

  toInt() {
    switch (this) {
      case user:
        return 0;
      case guide:
        return 1;
    }
  }
}
