import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/get_all_activity_use_case.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/get_all_regions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<ActivityRemoteModel> activityList = [];
  List<ActivityRemoteModel> topRated = [];
  List<ActivityRemoteModel> nearby = [];
  List<RegionModel> regionList = [];

  HomeBloc() : super(HomeInitial()) {
    on<GetAllActivityEvent>((event, emit) async {
      emit(GetAllActivityLoading());
      final res = await GetAllActivityUseCase().call(NoParams());
      res.fold(
        (l) => emit(GetAllActivityError()),
        (r) {
          activityList = r.data?.data ?? [];
          emit(GetAllActivityLoaded());
        },
      );
    });
    on<GetAllRegionEvent>((event, emit) async {
      emit(GetAllRegionLoading());
      final res = await GetAllRegionUseCase().call(NoParams());
      res.fold(
        (l) => emit(GetAllRegionError()),
        (r) {
          regionList = r.data ?? [];
          emit(GetAllRegionLoaded());
        },
      );
    });
    on<GetNearbyActivityEvent>((event, emit) async {
      emit(GetNearByLoading());
      final res = await GetNearbyLocationUseCase().call(
        GetNearbyActivityParamsModel(
          latitude: AppSettings().currentLocation?.latitude ?? 0,
          longitude: AppSettings().currentLocation?.latitude ?? 0,
        ),
      );
      res.fold(
        (l) => emit(GetNearByError()),
        (r) {
          nearby = r.data ?? [];
          emit(GetNearByLoaded());
        },
      );
    });
    on<GetTopRatedActivityEvent>((event, emit) async {
      emit(GetTopRatedLoading());
      final res = await ShowTopRatedUseCase().call(NoParams());
      res.fold(
        (l) => emit(GetTopRatedError()),
        (r) {
          print(r.topRated?.length);
          topRated = r.topRated ?? [];
          emit(GetTopRatedLoaded());
        },
      );
    });
  }
}
