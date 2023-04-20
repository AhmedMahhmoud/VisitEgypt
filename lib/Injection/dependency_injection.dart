import 'package:get_it/get_it.dart';
import 'package:visit_egypt/Features/Home/Logic/trip_trepository.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';
import 'package:visit_egypt/Features/MachineLearning/View/cubit/machine_learning_cubit.dart';

import '../Features/Auth/Logic/respository.dart';
import '../Features/Auth/View/cubit/auth_cubit.dart';
import '../Features/Home/Logic/home_respository.dart';
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

  /// Trips Dependencies
  sl.registerFactory(() => TripsCubit(tripRepo: sl()));
  sl.registerLazySingleton<TripRepo>(() => TripRepoImpl());

  //ML
  sl.registerFactory(() => MachineLearningCubit());
}
