import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:task/Features/Auth/View/login_page.dart';
import 'package:task/Features/Auth/cubit/auth_cubit.dart';
import 'package:task/Injection/dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.initGitIt();
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
            ],
            child: const MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Task',
                home: LoginPage()));
      },
    );
  }
}
