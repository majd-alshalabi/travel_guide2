import 'package:dartz/dartz.dart';
import 'package:travel_guide/core/models/user_case_model.dart';
import 'package:travel_guide/feature/home_page/data/models/remote/wether_api.dart';
import 'package:travel_guide/feature/home_page/data/repositories/home_repositories.dart';

class GetWitherOneDayUseCase extends UseCase<WitherApiModel, WitherApiParams> {
  HomeRepositories repository = HomeRepositories();

  @override
  Future<Either<String, WitherApiModel>> call(WitherApiParams params) async {
    return await repository.getWitherApi(params);
  }
}
