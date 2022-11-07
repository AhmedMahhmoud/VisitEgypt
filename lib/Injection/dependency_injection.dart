import 'package:get_it/get_it.dart';
import 'package:task/Features/Auth/Logic/respository.dart';
import 'package:task/Features/Auth/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> initGitIt() async {
  sl.registerFactory(() => AuthCubit(authRepository: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
}
