import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/account/data/models/remote/get_guide_models.dart';
import 'package:travel_guide/feature/account/data/repositories/account_repositories.dart';

class GetGuidesUseCase extends UseCase<GetAllGuideResponseModel, NoParams> {
  AccountRepositories repository = AccountRepositories();

  @override
  Future<Either<String, GetAllGuideResponseModel>> call(
    NoParams params,
  ) async {
    return repository.getAllGuide();
  }
}
