class ToggleBookMarkResponseModel {
  String? message;

  ToggleBookMarkResponseModel({this.message});

  ToggleBookMarkResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

class ToggleBookMarkParamsModel {
  int? adsId;

  ToggleBookMarkParamsModel({this.adsId});

  ToggleBookMarkParamsModel.fromJson(Map<String, dynamic> json) {
    adsId = json['ads_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ads_id'] = this.adsId;
    return data;
  }
}
