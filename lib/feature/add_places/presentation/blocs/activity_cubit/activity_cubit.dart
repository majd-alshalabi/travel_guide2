import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/add_places/data/models/remote/city_models.dart';
import 'package:travel_guide/feature/add_places/domain/use_cases/add_activity_use_case.dart';
import 'package:travel_guide/feature/add_places/domain/use_cases/get_all_city_use_case.dart';
import 'package:travel_guide/feature/add_places/domain/use_cases/get_region_use_case.dart';


part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitial());
  void initState() async {
    emit(GetAllCityLoading());
    final res = await GetAllCityUseCase().call(NoParams());
    res.fold(
          (l) => emit(GetAllCityError()),
          (r) {
        emit(GetAllCityLoaded(r.data ?? []));
      },
    );
  }
  void getRegionById(int id) async {
    emit(GetAllRegionLoading());
    final res = await GetRegionUseCase().call(GetRegionParamsModel(cityId: id));
    res.fold(
          (l) => emit(GetAllRegionError()),
          (r) {
        emit(
          GetAllRegionLoaded(r.data ?? []),
        );
      },
    );
  }



  void addCity(String name) async {
    emit(AddCityLoading());
    final res = await AddCityUseCase().call(AddCityParamsModel(name: name));
    res.fold(
      (l) => emit(AddCityError()),
      (r) {
        emit(AddCityLoaded(r.data));
      },
    );
  }

  void addActivity(AddActivityParamsModel params) async {
    emit(AddActivityLoading());
    final res = await AddActivityUseCase().call(params);
    res.fold(
      (l) => emit(AddActivityError()),
      (r) {
        emit(AddActivityLoaded());
      },
    );
  }

  void addRegion(String name, int id, List<String> images) async {
    emit(AddRegionLoading());
    final res = await AddRegionUseCase()
        .call(AddRegionParamsModel(cityId: id, name: name, images: images));
    res.fold(
      (l) => emit(AddRegionError()),
      (r) {
        emit(AddRegionLoaded(r.data, id));
      },
    );
  }
}
