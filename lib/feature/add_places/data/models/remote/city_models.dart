class GetAllCityResponseModel {
  String? message;
  List<CityModel>? data;

  GetAllCityResponseModel({this.message, this.data});

  GetAllCityResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CityModel>[];
      json['data'].forEach((v) {
        data!.add(CityModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
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

class GetRegionParamsModel {
  final int cityId;

  GetRegionParamsModel({
    required this.cityId,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_id'] = cityId;
    return data;
  }
}

class GetAllRegionResponseModel {
  String? message;
  List<RegionModel>? data;

  GetAllRegionResponseModel({this.message, this.data});

  GetAllRegionResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <RegionModel>[];
      json['data'].forEach((v) {
        data!.add(RegionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegionModel {
  int? id;
  int? cityId;
  String? name;
  String? createdAt;
  String? updatedAt;

  RegionModel(
      {this.id, this.name, this.createdAt, this.updatedAt, this.cityId});

  RegionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_id'] = cityId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AddCityParamsModel {
  final String name;

  AddCityParamsModel({
    required this.name,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class AddCityResponseModel {
  CityModel? data;

  AddCityResponseModel({this.data});

  AddCityResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = CityModel.fromJson(json['data']);
    }
  }
}

class AddRegionParamsModel {
  final String name;
  final int cityId;
  final List<String> images;

  AddRegionParamsModel({
    required this.images,
    required this.name,
    required this.cityId,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['city_id'] = cityId;
    data['images'] = images;
    return data;
  }
}

class AddRegionResponseModel {
  RegionModel? data;

  AddRegionResponseModel({this.data});

  AddRegionResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = RegionModel.fromJson(json['data']);
    }
  }
}
