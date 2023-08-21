import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/wether_api.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/get_all_activity_use_case.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/get_wither_for_one_day.dart';

part 'region_details_state.dart';

class RegionDetailsCubit extends Cubit<RegionDetailsState> {
  RegionDetailsCubit() : super(RegionDetailsInitial());
  WitherApiModel? witherModel;
  WitherApiModel? fiveDayWitherModel;
  List<ActivityRemoteModel> activityList = [];
  void getWitherForOneDay(
    double lang,
    double lat,
  ) async {
    emit(GetWitherOneDayLoading());
    final res = await GetWitherOneDayUseCase().call(
      WitherApiParams(lang: lang, lat: lat, oneDay: true),
    );
    res.fold(
      (l) => emit(GetWitherOneDayError()),
      (r) {
        witherModel = r;
        emit(GetWitherOneDayLoaded());
      },
    );
  }

  void getWitherForFiveDay(
    double lang,
    double lat,
  ) async {
    emit(GetWitherFiveDayLoading());
    final res = await GetWitherOneDayUseCase().call(
      WitherApiParams(lang: lang, lat: lat, oneDay: false),
    );
    res.fold(
      (l) => emit(GetWitherFiveDayError()),
      (r) {
        fiveDayWitherModel = r;
        emit(GetWitherFiveDayLoaded());
      },
    );
  }

  void getActivityInRegion(int regionId) async {
    await Future.delayed(Duration(milliseconds: 100));
    emit(GetActivityInRegionLoading());
    final res = await GetActivityInRegion()
        .call(GetActivityInRegionParamsModel(regionId: regionId));
    res.fold(
      (l) => emit(GetActivityInRegionError()),
      (r) {
        activityList = r.data ?? [];
        emit(GetActivityInRegionLoaded());
      },
    );
  }
}
