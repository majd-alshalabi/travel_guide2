class GetActivityResponseModel {
  String? message;
  List<ActivityRemoteModel>? data;

  GetActivityResponseModel({this.message, this.data});

  GetActivityResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ActivityRemoteModel>[];
      json['data'].forEach((v) {
        data!.add(new ActivityRemoteModel.fromJson(v));
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

class GetTopRatedResponseModel {
  List<ActivityRemoteModel>? topRated;

  GetTopRatedResponseModel({this.topRated});

  GetTopRatedResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['Top_Rated'] != null) {
      topRated = <ActivityRemoteModel>[];
      json['Top_Rated'].forEach((v) {
        topRated!.add(new ActivityRemoteModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topRated != null) {
      data['Top_Rated'] = this.topRated!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivityRemoteModel {
  List<ImageModel>? url;
  int? activityId;
  int? regionId;
  String? name;
  String? type;
  String? description;
  int? price;
  double? latitude;
  double? longitude;

  ActivityRemoteModel(
      {this.url,
      this.activityId,
      this.regionId,
      this.name,
      this.type,
      this.description,
      this.price,
      this.latitude,
      this.longitude});

  ActivityRemoteModel.fromJson(Map<String, dynamic> json) {
    if (json['url'] != null) {
      url = <ImageModel>[];
      json['url'].forEach((v) {
        url!.add(new ImageModel.fromJson(v));
      });
    }
    activityId = json['activity_id'];
    regionId = json['region_id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    price = json['price'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.url != null) {
      data['url'] = this.url!.map((v) => v.toJson()).toList();
    }
    data['activity_id'] = this.activityId;
    data['region_id'] = this.regionId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['description'] = this.description;
    data['price'] = this.price;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class ImageModel {
  String? url;

  ImageModel({this.url});

  ImageModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
