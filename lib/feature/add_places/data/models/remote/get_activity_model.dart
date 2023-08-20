

import 'city_models.dart';

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

class ActivityRemoteModel {
  int? id;
  int? regionId;
  String? name;
  String? type;
  String? description;
  int? price;
  double? latitude;
  double? longitude;
  int? adminId;
  int? guideId;
  int? rating;
  List<Images>? urls;
  RegionModel? region;
  CityModel? city;

  ActivityRemoteModel(
      {this.id,
      this.regionId,
      this.name,
      this.type,
      this.description,
      this.price,
      this.latitude,
      this.longitude,
      this.adminId,
      this.guideId,
      this.rating,
      this.urls,
      this.region,
      this.city,});

  ActivityRemoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regionId = json['region_id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    price = json['price'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    adminId = json['admin_id'];
    guideId = json['guide_id'];
    rating = json['rating'];
    if (json['urls'] != null) {
      urls = <Images>[];
      json['urls'].forEach((v) {
        urls!.add(Images.fromJson(v));
      });
    }
    region =
        json['region'] != null ? RegionModel.fromJson(json['region']) : null;
    city = json['city'] != null ? CityModel.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['region_id'] = regionId;
    data['name'] = name;
    data['type'] = type;
    data['description'] = description;
    data['price'] = price;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['admin_id'] = adminId;
    data['guide_id'] = guideId;
    data['rating'] = rating;
    if (urls != null) {
      data['urls'] = urls!.map((v) => v.toJson()).toList();
    }
    if (region != null) {
      data['region'] = region!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}

class Images {
  String? url;

  Images({this.url});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}

class GetActivityParamsModel{
  final int page ;

  GetActivityParamsModel(this.page);
}