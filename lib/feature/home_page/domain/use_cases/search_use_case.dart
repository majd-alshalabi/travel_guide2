import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/search_model.dart';
import 'package:travel_guide/feature/home_page/data/repositories/home_repositories.dart';

class SearchUseCase extends UseCase<SearchResponseModel, SearchParamsModel> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, SearchResponseModel>> call(
      SearchParamsModel params) async {
    return await repository.search(params);
  }
}
