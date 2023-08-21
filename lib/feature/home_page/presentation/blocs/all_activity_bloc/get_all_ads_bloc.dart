import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/get_all_activity_use_case.dart';

part 'get_all_ads_event.dart';
part 'get_all_ads_state.dart';

class GetAllAdsBloc extends Bloc<GetAllAdsEvent, GetAllAdsState> {
  List<ActivityRemoteModel> listOfAllAds = [];
  int page = 1;
  bool lastPage = false;

  GetAllAdsBloc() : super(GetAllAdsInitial()) {
    on<GetNewAdsEvents>((event, emit) async {
      if (page != 1) {
        emit(GettingNewPageLoading());
      } else {
        emit(LoadingGetAllAds());
      }
      final result = await GetAllActivityUseCase().call(
        GetActivityParamsModel(
          page: page,
        ),
      );
      result.fold(
        (l) => emit(ErrorGetAllAds()),
        (r) {
          List<ActivityRemoteModel?> tempList = [];
          tempList.addAll(r.data?.data ?? []);
          for (int i = 0; i < tempList.length; i++) {
            var element = tempList[i];
            int index = listOfAllAds
                .indexWhere((element2) => element?.id == element2.id);
            if (index != -1) {
              r.data?.data?.removeAt(i);
            }
          }
          listOfAllAds.addAll(r.data?.data ?? []);
          if (r.data?.data?.length != 10) lastPage = true;
          page++;
          emit(CompleteGetAllAds());
        },
      );
    });

    on<UpdateAllPostPage>((event, emit) async {
      emit(LoadingForAnyThingButNotGetAllAds());
      lastPage = false;
      page = 2;
      listOfAllAds = event.list;
      if (event.list.length != 10) lastPage = true;
      emit(CompleteGetAllAds());
    });
    on<ReGetEvent>((event, emit) async {
      emit(LoadingGetAllAds());
      lastPage = false;
      page = 1;
      final result = await GetAllActivityUseCase().call(
        GetActivityParamsModel(page: page),
      );
      result.fold(
        (l) => emit(ErrorGetAllAds()),
        (r) {
          List<ActivityRemoteModel?> tempList = [];
          tempList.addAll(r.data?.data ?? []);
          for (int i = 0; i < tempList.length; i++) {
            var element = tempList[i];
            int index = listOfAllAds
                .indexWhere((element2) => element?.id == element2.id);
            if (index != -1) {
              r.data?.data?.removeAt(i);
            }
          }
          listOfAllAds.addAll(r.data?.data ?? []);
          if (r.data?.data?.length != 10) lastPage = true;
          page++;
          emit(CompleteGetAllAds());
        },
      );
    });
  }
}
