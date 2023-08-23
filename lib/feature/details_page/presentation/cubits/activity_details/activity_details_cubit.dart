import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';

part 'activity_details_state.dart';

class ActivityDetailsCubit extends Cubit<ActivityDetailsState> {
  final int id;
  StreamSubscription? streamSubscription;

  ActivityDetailsCubit(this.id) : super(ActivityDetailsInitial()) {
    streamSubscription = AppSettings().likeStream.stream.listen((event) {
      if (event is ToggleLike && event.id == id) {
        updateLikeButton(event);
      }
    });
  }
  @override
  Future<void> close() async {
    streamSubscription?.cancel();
    super.close();
  }

  updateLikeButton(ToggleLike model) {
    emit(UpdateLikeLoading());
    emit(UpdateLikeLoaded(model.added));
  }
}
