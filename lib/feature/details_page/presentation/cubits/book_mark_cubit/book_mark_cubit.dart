import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/core/services/app_settings/app_settings.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/book_mark_models.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/book_mark_use_case.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/get_all_activity_use_case.dart';

part 'book_mark_state.dart';

class BookMarkCubit extends Cubit<BookMarkState> {
  BookMarkCubit() : super(BookMarkInitial());
  List<ActivityRemoteModel> bookmarked = [];
  void addToBookMark(int id) async {
    emit(AddToBookMarkLoading());
    final res = await ToggleBookMarkUseCase()
        .call(ToggleBookMarkParamsModel(adsId: id));
    res.fold((l) => emit(AddToBookMarkError()), (r) {
      AppSettings().likeStream.add(ToggleLike(id, r.added ?? false));
      emit(AddToBookMarkLoaded(id, r.added ?? false));
    });
  }

  void getBookMark() async {
    emit(GetBookMarkedLoading());
    final res = await GetBookMarked().call(NoParams());
    res.fold((l) => emit(GetBookMarkedError()), (r) {
      bookmarked = r.data ?? [];
      emit(GetBookMarkedLoaded());
    });
  }
}
