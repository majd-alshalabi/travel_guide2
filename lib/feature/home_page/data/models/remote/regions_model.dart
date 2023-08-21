import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';

class GetRegionResponseModel {
  String? message;
  List<RegionModel>? data;

  GetRegionResponseModel({this.message, this.data});

  GetRegionResponseModel.fromJson(Map<String, dynamic> json) {
    print(json);
    print("adsfdasfads");
    message = json['message'];
    if (json['data'] != null) {
      data = <RegionModel>[];
      json['data'].forEach((v) {
        data!.add(new RegionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
