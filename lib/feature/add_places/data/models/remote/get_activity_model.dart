import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';

class GetActivityResponseModel {
  String? message;
  PaginationData? data;

  GetActivityResponseModel({this.message, this.data});

  GetActivityResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? PaginationData.fromJson(json['data']) : null;
  }
}

class PaginationData {
  List<ActivityRemoteModel>? data;
  PaginationData({
    this.data,
  });

  PaginationData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ActivityRemoteModel>[];
      json['data'].forEach((v) {
        data!.add(ActivityRemoteModel.fromJson(v));
      });
    }
  }
}
