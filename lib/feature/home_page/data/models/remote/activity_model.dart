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

class GetNearbyActivityResponseModel {
  String? message;
  List<ActivityRemoteModel>? data;

  GetNearbyActivityResponseModel({this.message, this.data});

  GetNearbyActivityResponseModel.fromJson(Map<String, dynamic> json) {
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

class GetNearbyActivityParamsModel {
  double? latitude;
  double? longitude;

  GetNearbyActivityParamsModel({this.latitude, this.longitude});

  GetNearbyActivityParamsModel.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class GetTopRatedResponseModel {
  List<ActivityRemoteModel>? topRated;

  GetTopRatedResponseModel({this.topRated});

  GetTopRatedResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      topRated = <ActivityRemoteModel>[];

      json['data'].forEach((v) {
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
  AdminModel? admin;

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
      this.city,
      this.admin});

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
    admin = json['admin'] != null ? AdminModel.fromJson(json['admin']) : null;
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
    if (admin != null) {
      data['admin'] = admin!.toJson();
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

class RegionModel {
  int? id;
  int? cityId;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Images>? images;
  CityModel? city;

  RegionModel(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.cityId,
      this.city,
      this.images});

  RegionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['city'] != null) {
      city = CityModel.fromJson(json['city']);
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_id'] = cityId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['images'] = images;
    data['city'] = city;
    return data;
  }
}

class CityModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  CityModel({this.id, this.name, this.createdAt, this.updatedAt});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AdminModel {
  int? id;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;

  AdminModel({this.id, this.name, this.email, this.createdAt, this.updatedAt});

  AdminModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
