// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Enums/firebase_request_enum.dart';
import 'package:visit_egypt/Features/Home/View/widgets/tourist_page_display.dart';

import '../../Enums/user_type.dart';
import '../Auth/View/cubit/auth_cubit.dart';
import '../Home/View/Cubit/home_cubit.dart';
import '../Home/View/Cubit/trips_cubit.dart';
import '../Home/View/screens/home_page.dart';
import '../Home/View/screens/tourguide_registeration_page.dart';
import '../More/views/more_screen.dart';
import '../Posts/View/pages/posts_screen.dart';

// ignore: must_be_immutable
class BottomNav extends StatefulWidget {
  int comingIndex = -1;
  final FirebaseRequestType firebaseRequestType;
  BottomNav(
      {super.key,
      required this.comingIndex,
      required this.firebaseRequestType});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 1;
  late final UserTypeEnum userTypeEnum;
  @override
  void initState() {
    super.initState();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print("Received message");
    //   print(message.notification!.title);
    //   print(message.notification!.body);
    //   LocalNotification localNotification = LocalNotification();
    //   localNotification.sendNotification(
    //       message.notification!.title!, message.notification!.body!);
    // }).onError((e) {
    //   print('ee $e');
    // });
    // print("listening for message");

    (widget.comingIndex != -1)
        ? currentIndex = widget.comingIndex
        : currentIndex = 0;
    getUserType();
    if (userTypeEnum == UserTypeEnum.tourist) {
      BlocProvider.of<HomeCubit>(context).getUserAddress();
      BlocProvider.of<HomeCubit>(context).getAllPlaces();
      BlocProvider.of<TripsCubit>(context).getAllcreatedTrips();
    } else {
      BlocProvider.of<AuthCubit>(context).getTourguideProfile();
    }
  }

  getUserType() {
    final userType = BlocProvider.of<AuthCubit>(context).userTypeEnum;
    userTypeEnum = userType;
  }

  final touristTabs = [const HomePage(), const PostsPage(), const MoreScreen()];
  final tourGuide = [
    const HomePage(),
    const TouristPageDisplay(),
    const PostsPage(),
    const MoreScreen()
  ];
  //final keyOne = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return widget.firebaseRequestType == FirebaseRequestType.register &&
            userTypeEnum == UserTypeEnum.tourguide
        ? const TourguideRegisterationPage()
        : Scaffold(
            body: userTypeEnum == UserTypeEnum.tourist
                ? touristTabs[currentIndex]
                : tourGuide[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.black,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              currentIndex: currentIndex,
              elevation: 20,
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/home.png',
                      height: 30.h,
                    ),
                    label: "Home"),
                if (userTypeEnum == UserTypeEnum.tourguide) ...[
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/tourguide.png',
                        height: 30.h,
                      ),
                      label: "Tour"),
                ],
                BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/posts.png',
                      height: 30.h,
                    ),
                    label: "Posts"),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/gear.png',
                      height: 30.h,
                    ),
                    label: "More")
              ],
            ),
          );
  }
}
