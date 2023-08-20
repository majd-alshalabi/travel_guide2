import 'package:travel_guide/core/services/network/network_configrations.dart';
import 'package:travel_guide/core/services/network/network_interface.dart';
import 'package:travel_guide/core/services/network/network_service.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/city_models.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/get_activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';

class ActivityRemoteDataSource {
  NetworkServices networkServices = NetworkServices();

  Future<AddActivityResponseModel> addActivity(
      AddActivityParamsModel params) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kAddActivity,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(AddActivityResponseModel.fromJson(res));
  }

  Future<GetActivityResponseModel> getActivity(
      GetActivityParamsModel params) async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: {},
        networkPath: NetworkConfigurations.kGetActivity,
        urlParams: <String, dynamic>{"page": params.page},
      ),
    );
    return Future.value(GetActivityResponseModel.fromJson(res));
  }

  Future<GetAllCityResponseModel> getAllCities() async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: {},
        networkPath: NetworkConfigurations.kGetAllCity,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(GetAllCityResponseModel.fromJson(res));
  }

  Future<AddCityResponseModel> addCity(AddCityParamsModel params) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kAddCity,
        urlParams: <String, String>{},
      ),
    );

    return Future.value(AddCityResponseModel.fromJson(res));
  }

  Future<GetAllRegionResponseModel> getRegion(
      GetRegionParamsModel params) async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kGetRegion,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(GetAllRegionResponseModel.fromJson(res));
  }

  Future<AddRegionResponseModel> addRegion(AddRegionParamsModel params) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kAddRegion,
        urlParams: <String, String>{},
      ),
    );

    return Future.value(AddRegionResponseModel.fromJson(res));
  }
}
