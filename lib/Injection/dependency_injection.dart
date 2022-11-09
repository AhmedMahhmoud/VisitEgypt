import 'package:get_it/get_it.dart';
import 'package:task/Features/Auth/Logic/respository.dart';
import 'package:task/Features/Auth/cubit/auth_cubit.dart';

import '../Features/Home/Cubit/home_cubit.dart';
import '../Features/Home/Logic/respository.dart';

final sl = GetIt.instance;

Future<void> initGitIt() async {

  /// Auth Dependencies
  sl.registerFactory(() => AuthCubit(authRepository: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());

  /// Home Dependencies
  sl.registerFactory(() => HomeCubit(homeRepository: sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImp());
}
