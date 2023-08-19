import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';

class GetAllGuideResponseModel {
  List<GuideModel>? data;

  GetAllGuideResponseModel({this.data});

  GetAllGuideResponseModel.fromJson(List<dynamic> json) {
    data = <GuideModel>[];
    for (var v in json) {
      data!.add(GuideModel.fromJson(v));
    }
  }
}
