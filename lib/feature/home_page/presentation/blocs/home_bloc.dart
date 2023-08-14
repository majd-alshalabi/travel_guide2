import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/get_all_activity_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<ActivityRemoteModel> activityList = [];

  HomeBloc() : super(HomeInitial()) {
    on<GetAllActivityEvent>((event, emit) async {
      emit(GetAllActivityLoading());
      final res = await GetAllActivityUseCase().call(NoParams());
      res.fold(
        (l) => emit(GetAllActivityError()),
        (r) {
          activityList = r.data ?? [];
          emit(GetAllActivityLoaded());
        },
      );
    });
  }
}
