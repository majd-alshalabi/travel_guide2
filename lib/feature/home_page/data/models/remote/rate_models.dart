class AddRateResponseModel {
  String? message;

  AddRateResponseModel({this.message});

  AddRateResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

class AddRateParamsModel {
  int? rate;
  int? activityId;

  AddRateParamsModel({this.rate, this.activityId});

  AddRateParamsModel.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    activityId = json['activity_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['activity_id'] = this.activityId;
    return data;
  }
}

class AddGuideRateResponseModel {
  String? message;

  AddGuideRateResponseModel({this.message});

  AddGuideRateResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

class AddGuideRateParamsModel {
  int? rate;
  int? guide_id;

  AddGuideRateParamsModel({this.rate, this.guide_id});

  AddGuideRateParamsModel.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    guide_id = json['guide_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['guide_id'] = this.guide_id;
    return data;
  }
}
