import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/book_mark_models.dart';
import 'package:travel_guide/feature/home_page/data/repositories/home_repositories.dart';

class ToggleBookMarkUseCase
    extends UseCase<ToggleBookMarkResponseModel, ToggleBookMarkParamsModel> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, ToggleBookMarkResponseModel>> call(
      ToggleBookMarkParamsModel params) async {
    return await repository.toggleBookMark(params);
  }
}
