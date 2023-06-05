// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Enums/firebase_request_enum.dart';
import 'package:visit_egypt/Features/Home/View/widgets/tourist_page_display.dart';
import 'package:visit_egypt/Features/MachineLearning/View/machine_learning_page.dart';

import '../../Enums/user_type.dart';
import '../Auth/View/cubit/auth_cubit.dart';
import '../Home/View/Cubit/home_cubit.dart';
import '../Home/View/Cubit/trips_cubit.dart';
import '../Home/View/screens/admin_page.dart';
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
  late UserTypeEnum userTypeEnum;
  bool? isTourGuideActivated;
  bool isDataLoading = false;
  @override
  void initState() {
    super.initState();

    (widget.comingIndex != -1)
        ? currentIndex = widget.comingIndex
        : currentIndex = 0;
    getUserType();
    if (userTypeEnum == UserTypeEnum.tourist) {
      BlocProvider.of<HomeCubit>(context).getUserAddress();
      BlocProvider.of<HomeCubit>(context).getAllPlaces();
      BlocProvider.of<TripsCubit>(context).getAllcreatedTrips();
    }
  }

  getUserType() async {
    var authCubit = BlocProvider.of<AuthCubit>(context);
    final userType = authCubit.userTypeEnum;
    userTypeEnum = userType;
    if (userTypeEnum == UserTypeEnum.tourguide) {
      setState(() {
        isDataLoading = true;
      });
      await BlocProvider.of<AuthCubit>(context).getTourguideProfile();
      if (isTourGuideActivated == null) {
        setState(() {
          isTourGuideActivated =
              authCubit.tourguideRegisterModel!.isAccountActivated;
        });
      }
      setState(() {
        isDataLoading = false;
      });
      print("TOURGUIDE ACCONT STATUS IS $isTourGuideActivated");
    }
  }

  final touristTabs = [
    const HomePage(),
    const PostsPage(),
    const MoreScreen(),
    const MachineLearningPage()
  ];
  final tourGuide = [
    const HomePage(),
    const TouristPageDisplay(),
    const PostsPage(),
    const MoreScreen(),
    const MachineLearningPage()
  ];
  //final keyOne = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return widget.firebaseRequestType == FirebaseRequestType.register &&
            userTypeEnum == UserTypeEnum.tourguide
        ? const TourguideRegisterationPage()
        : userTypeEnum == UserTypeEnum.admin
            ? const AdminPage()
            : Scaffold(
                body: userTypeEnum == UserTypeEnum.tourguide &&
                        (isTourGuideActivated == false ||
                            isTourGuideActivated == null)
                    ? Container(
                        color: CustomColors.niceYellow,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isTourGuideActivated == false
                                    ? "Your account is not yet verified by admin"
                                    : "Your account is rejected by admin",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              isDataLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : SizedBox(
                                      width: 150.w,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        onPressed: () async {
                                          if (isTourGuideActivated == false) {
                                            getUserType();
                                          } else {
                                            setState(() {
                                              isDataLoading = true;
                                            });
                                            await BlocProvider.of<TripsCubit>(
                                                    context)
                                                .activateGuideAccount(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    TourGuideApplicationEnum
                                                        .resubmit);
                                            setState(() {
                                              isDataLoading = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Request resubmited successfully")));
                                          }
                                        },
                                        color: Colors.black,
                                        child: Text(
                                          isTourGuideActivated == false
                                              ? "Retry .."
                                              : "Reusbmit",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              const LogOut()
                            ],
                          ),
                        ),
                      )
                    : userTypeEnum == UserTypeEnum.tourist
                        ? touristTabs[currentIndex]
                        : tourGuide[currentIndex],
                bottomNavigationBar: userTypeEnum == UserTypeEnum.tourguide &&
                        (isTourGuideActivated == false ||
                            isTourGuideActivated == null)
                    ? null
                    : BottomNavigationBar(
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
                              label: "More"),
                          BottomNavigationBarItem(
                              icon: Image.asset(
                                'assets/images/camera.png',
                                height: 30.h,
                              ),
                              label: "Predict")
                        ],
                      ),
              );
  }
}
