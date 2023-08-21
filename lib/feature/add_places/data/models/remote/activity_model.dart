class AddActivityParamsModel {
  final int regionId;
  final String name;
  final String type;
  final String description;
  final String price;
  final double latitude;
  final double longitude;
  final List<String> images;
  AddActivityParamsModel({
    required this.name,
    required this.regionId,
    required this.type,
    required this.price,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.images,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['region_id'] = regionId;
    data['type'] = type;
    data['price'] = price;
    data['description'] = description;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['images'] = images;
    return data;
  }
}

class AddActivityResponseModel {
  String? message;

  AddActivityResponseModel({this.message});

  AddActivityResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
