import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';
import 'package:visit_egypt/Features/MachineLearning/View/cubit/machine_learning_cubit.dart';
import 'package:visit_egypt/Injection/dependency_injection.dart' as di;
import 'Core/Shared/SharedPreferences (Singelton)/shared_pref.dart';
import 'Features/Auth/View/cubit/auth_cubit.dart';
import 'Features/Home/View/Cubit/home_cubit.dart';
import 'Features/Posts/View/cubit/posts_cubit.dart';
import 'Features/Splash/View/splash_screen.dart';
import 'Services/Geolocator/geolocator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'Services/Push_Notifications/local_notifications.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
);

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('logo');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.initGitIt();
  await Prefs.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Position userLocation = await GeoLocatorService.getCurrentUserLocation();
  Prefs.setDouble('UserLat', userLocation.latitude);
  Prefs.setDouble('UserLng', userLocation.longitude);
/*  runApp(DevicePreview(
      builder: (context)=>
     const MyApp());*/

  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {},
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("onMessageReceived:}");
    LocalNotification localNotification = LocalNotification();
    localNotification.showNotification(
        message.notification?.title ?? '', message.notification?.body ?? '');
  });
  runApp(const MyApp());
}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print("Handling a background message");
  inspect(message);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => di.sl<AuthCubit>()),
              BlocProvider(create: (_) => di.sl<HomeCubit>()..getAllPlaces()),
              BlocProvider(create: (_) => di.sl<TripsCubit>()),
              BlocProvider(
                  create: (_) => di.sl<MachineLearningCubit>()..loadModel()),
              BlocProvider(
                create: (context) => di.sl<PostsCubit>(),
              )
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: navigatorKey,
                useInheritedMediaQuery: true,
                title: 'Visit Egypt',
                // home: const MachineLearningPage()
                //BottomNav(comingIndex: 0)
                //const HomePage()
                home: const SplashScreen()));
      },
    );
  }
}
