import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:visit_egypt/Injection/dependency_injection.dart' as di;
import 'Core/Shared/SharedPreferences (Singelton)/shared_pref.dart';
import 'Features/Auth/View/cubit/auth_cubit.dart';
import 'Features/Home/View/Cubit/home_cubit.dart';
import 'Features/Home/View/homepage.dart';
import 'Features/Posts/View/cubit/posts_cubit.dart';
import 'Features/Splash/View/splash_screen.dart';
import 'Features/bottom_navigation/bottom_navigatio.dart';
import 'Services/Geolocator/geolocator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.initGitIt();
  await Prefs.init();
  Position userLocation = await GeoLocatorService.getCurrentUserLocation();
  Prefs.setDouble('UserLat', userLocation.latitude);
  Prefs.setDouble('UserLng', userLocation.longitude);
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
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: navigatorKey,
                title: 'Visit Egypt',
                home:
                const SplashScreen()
                //BottomNav(comingIndex: 0)
                //const HomePage()

                ));
      },
    );
  }
}
