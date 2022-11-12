import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:task/Core/Shared/SharedPreferences%20(Singelton)/shared_pref.dart';
import 'package:task/Features/Posts/View/cubit/posts_cubit.dart';
import 'package:task/Injection/dependency_injection.dart' as di;

import 'Features/Auth/View/cubit/auth_cubit.dart';
import 'Features/Home/View/Cubit/home_cubit.dart';
import 'Features/Posts/View/pages/posts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.initGitIt();
  await Prefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72, 807.27),
      builder: (context, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => di.sl<AuthCubit>()),
              BlocProvider(create: (_) => di.sl<HomeCubit>()..getAllPlaces()),
              BlocProvider(
                create: (context) => di.sl<PostsCubit>(),
              )
            ],
            child: const MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Task',
                home: PostsPage()));
      },
    );
  }
}
