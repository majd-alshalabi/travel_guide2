class AddCommentResponseModel {
  String? message;
  String? name;
  CommentModel? data;

  AddCommentResponseModel({this.message, this.name, this.data});

  AddCommentResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    name = json['name'];
    data =
        json['data'] != null ? new CommentModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['name'] = this.name;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CommentModel {
  String? message;
  String? activitiesId;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;
  UserModel? user;

  CommentModel(
      {this.message,
      this.activitiesId,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.user});

  CommentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    activitiesId = json['activities_id'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['activities_id'] = this.activitiesId;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class UserModel {
  int? id;
  String? name;
  String? email;
  String? number;
  String? image;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.number,
      this.image,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    number = json['number'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['number'] = this.number;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AddCommentParamsModel {
  int? activityId;
  String? message;

  AddCommentParamsModel({this.activityId, this.message});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_id'] = this.activityId;
    data['message'] = this.message;
    return data;
  }
}
