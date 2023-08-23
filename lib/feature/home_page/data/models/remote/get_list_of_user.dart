import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';

class GetListOfUserResponseModel {
  List<UserModel>? users;
  String? message;
  GetListOfUserResponseModel({this.users});

  GetListOfUserResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      users = <UserModel>[];
      json['data'].forEach((v) {
        users!.add(new UserModel.fromJson(v));
      });
    }
  }
}

class GetListOfUserParamsModel {
  List<int>? ids;

  GetListOfUserParamsModel({this.ids});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_ids'] = this.ids;
    return data;
  }
}
