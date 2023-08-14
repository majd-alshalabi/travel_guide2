import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/comment_use_case.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());
  List<CommentModel> commentList = [];
  bool lastPage = false;
  void getCommentForCurrentPost(int activityId) async {
    emit(LoadingGetAllComment());

    // final result = await GetAllCommentUseCase().call(
    //   GetCommentParamsModel(adsId: activityId),
    // );
    // result.fold(
    //   (l) => emit(ErrorGetAllComment()),
    //   (r) {
    //     emit(CompleteGetAllComment());
    //   },
    // );
  }

  void addComment(AddCommentParamsModel comment) async {
    emit(AddCommentLoading());

    final res = await AddCommentUseCase().call(comment);
    res.fold((l) => emit(AddCommentError(l)), (r) {
      if (r.data != null) {
        commentList.insert(0, r.data!);
      }
      emit(CompleteGetAllComment());
    });
  }
}
