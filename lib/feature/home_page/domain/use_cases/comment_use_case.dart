import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/comment_models.dart';
import 'package:travel_guide/feature/home_page/data/repositories/home_repositories.dart';

class AddCommentUseCase
    extends UseCase<AddCommentResponseModel, AddCommentParamsModel> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, AddCommentResponseModel>> call(
      AddCommentParamsModel params) async {
    return await repository.addCommentModel(params);
  }
}
