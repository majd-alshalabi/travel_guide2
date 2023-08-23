import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/activity_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/search_model.dart';
import 'package:travel_guide/feature/home_page/domain/use_cases/search_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<ActivityRemoteModel> listOfAllAds = [];

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>(
      (event, emit) async {
        switch (event.runtimeType) {
          case NewSearchEvents:
            event as NewSearchEvents;
            listOfAllAds = [];
            emit(SearchLoading());
            final result = await SearchUseCase().call(
              SearchParamsModel(
                name: event.name,
              ),
            );
            result.fold(
              (l) => emit(SearchError()),
              (r) {
                listOfAllAds.clear();
                listOfAllAds = r.data ?? [];
                emit(SearchLoaded());
              },
            );
            break;
        }
      },
      transformer: restartable(),
    );
  }
}
