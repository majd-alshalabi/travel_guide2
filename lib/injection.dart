import 'package:get_it/get_it.dart';
import 'package:travel_guide/feature/add_places/presentation/blocs/activity_cubit/activity_cubit.dart';
import 'package:travel_guide/feature/other_feature/theme/presentation/blocs/theme_bloc/theme_cubit.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => ThemeCubit());
  sl.registerLazySingleton(() => ActivityCubit());
}
