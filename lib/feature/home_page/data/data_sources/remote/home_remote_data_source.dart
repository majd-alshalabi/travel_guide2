import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/core/services/network/network_interface.dart';
import 'package:travel_guide/core/services/network/network_service.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/book_mark_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/rate_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/regions_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/top_guide_model.dart';

class HomeRemoteDataSource {
  NetworkServices networkServices = NetworkServices();
  Future<AddRateResponseModel> addRate(AddRateParamsModel params) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kRateActivity,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(AddRateResponseModel.fromJson(res));
  }

  Future<AddGuideRateResponseModel> addGuideRate(
      AddGuideRateParamsModel params) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kRateGuide,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(AddGuideRateResponseModel.fromJson(res));
  }

  Future<ToggleBookMarkResponseModel> toggleBookMark(
      ToggleBookMarkParamsModel params) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kRateActivity,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(ToggleBookMarkResponseModel.fromJson(res));
  }

  Future<AddCommentResponseModel> addComment(
      AddCommentParamsModel params) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kAddComment,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(AddCommentResponseModel.fromJson(res));
  }

  Future<GetActivityResponseModel> getActivity() async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: {},
        networkPath: NetworkConfigurations.kGetAllActivity,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(GetActivityResponseModel.fromJson(res));
  }

  Future<GetRegionResponseModel> getAllRegion() async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: {},
        networkPath: NetworkConfigurations.kGetAllRegion,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(GetRegionResponseModel.fromJson(res));
  }

  Future<GetNearbyActivityResponseModel> getAllBookMarked() async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: {},
        networkPath: NetworkConfigurations.kGetBookMarked,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(GetNearbyActivityResponseModel.fromJson(res));
  }

  Future<GetNearbyActivityResponseModel> getNearbyLocation(
      GetNearbyActivityParamsModel params) async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kGetNearbyLocation,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(GetNearbyActivityResponseModel.fromJson(res));
  }

  Future<TopGuideResponseModel> getTopGuide() async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: {},
        networkPath: NetworkConfigurations.kGetTopGuide,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(TopGuideResponseModel.fromJson(res));
  }

  Future<GetTopRatedResponseModel> getTopRated() async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: {},
        networkPath: NetworkConfigurations.kGetTopRatedActivity,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(GetTopRatedResponseModel.fromJson(res));
  }
}
