import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_egypt/Enums/user_type.dart';
import 'package:visit_egypt/Features/Auth/View/cubit/auth_cubit.dart';

import '../../../../Core/Colors/app_colors.dart';
import '../Cubit/home_cubit.dart';
import '../widgets/tourguide_home.dart';
import '../widgets/tourist_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchedName = '';
  final _controller = ScrollController();
  late final UserTypeEnum userTypeEnum;
  @override
  void initState() {
    super.initState();
    getUserType();
    if (userTypeEnum == UserTypeEnum.tourist) {
      BlocProvider.of<HomeCubit>(context).getUserAddress();
      BlocProvider.of<HomeCubit>(context).getAllPlaces();
    }
  }

  getUserType() {
    final userType = BlocProvider.of<AuthCubit>(context).userTypeEnum;
    print("user type : $userType");
    userTypeEnum = userType;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.lightGold,
        body: SafeArea(
          bottom: false,
          child: userTypeEnum == UserTypeEnum.tourist
              ? Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/bgg.jpg',
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.white, BlendMode.softLight))),
                  child: TouristHome(controller: _controller))
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    TourGuideHome(),
                  ],
                ),
        ),
      ),
    );
  }
}
