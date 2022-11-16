import 'package:get_it/get_it.dart';


import '../Features/Auth/Logic/respository.dart';
import '../Features/Auth/View/cubit/auth_cubit.dart';
import '../Features/Home/Logic/respository.dart';
import '../Features/Home/View/Cubit/home_cubit.dart';
import '../Features/Posts/Logic/posts_repository.dart';
import '../Features/Posts/View/cubit/posts_cubit.dart';

final sl = GetIt.instance;

Future<void> initGitIt() async {
  /// Auth Dependencies
  sl.registerFactory(() => AuthCubit(authRepository: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());

  /// Home Dependencies
  sl.registerFactory(() => HomeCubit(homeRepository: sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImp());

  /// Posts Dependencies
  sl.registerFactory(() => PostsCubit(postsRepository: sl()));
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl());
}
