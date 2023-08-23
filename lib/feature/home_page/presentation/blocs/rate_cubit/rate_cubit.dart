import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/rate_models.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/add_rate_use_case.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  RateCubit() : super(RateInitial());

  void addRate(int rate, int activityId) async {
    emit(AddRateLoading());
    final res = await AddRateUseCase().call(
      AddRateParamsModel(rate: rate, activityId: activityId),
    );
    res.fold((l) => emit(AddRateError()), (r) => emit(AddRateLoaded()));
  }
}
