class ToggleBookMarkResponseModel {
  String? message;
  bool? added;
  ToggleBookMarkResponseModel({
    this.message,
    this.added,
  });

  ToggleBookMarkResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    added = json['added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['added'] = this.added;
    return data;
  }
}

class ToggleBookMarkParamsModel {
  int? adsId;

  ToggleBookMarkParamsModel({this.adsId});

  ToggleBookMarkParamsModel.fromJson(Map<String, dynamic> json) {
    adsId = json['activity_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_id'] = this.adsId;
    return data;
  }
}
