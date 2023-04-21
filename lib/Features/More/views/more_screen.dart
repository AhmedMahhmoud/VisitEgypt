import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_egypt/Enums/user_type.dart';
import 'package:visit_egypt/Features/Auth/View/cubit/auth_cubit.dart';
import 'package:visit_egypt/Features/Home/View/screens/created_trips.dart';

import '../../../Core/Colors/app_colors.dart';
import '../../../Core/Constants/constants.dart';
import '../../Auth/View/login_page.dart';
import '../../MachineLearning/View/machine_learning_page.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late final UserTypeEnum _userTypeEnum;
  @override
  void initState() {
    var authCubit = BlocProvider.of<AuthCubit>(context);
    _userTypeEnum = BlocProvider.of<AuthCubit>(context).userTypeEnum;
    if (_userTypeEnum == UserTypeEnum.tourguide) {
      if (authCubit.tourguideRegisterModel == null) {
        print("getting tourguide");
        authCubit.getTourguideProfile();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightGold,
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is TourGuideProfileLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.black,
                ),
              );
            } else if (state is TourGuideProfileErrorState) {
              return Center(
                  child: Text(
                state.errorMsg,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ));
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (_userTypeEnum == UserTypeEnum.tourguide &&
                      state is TourGuideProfileLoadedState) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Hello ${state.tourGuideRegisterModel.userName} 👋🏽',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Divider()
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 3, color: Colors.grey.withOpacity(0.7))),
                      child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              state.tourGuideRegisterModel.userImage!)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AbsorbPointer(
                      child: SizedBox(
                        child: TextFormField(
                          readOnly: true,
                          decoration: textFieldDecoration.copyWith(
                              hintText:
                                  state.tourGuideRegisterModel.phoneNumber,
                              icon: const Icon(Icons.phone),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ],
                  _userTypeEnum == UserTypeEnum.tourguide
                      ? SizedBox(
                          width: 200,
                          child: MaterialButton(
                              color: CustomColors.blackK,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreatedTripsPage(),
                                    ));
                              },
                              child: const AutoSizeText(
                                'My created trips',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.whiteK),
                              )),
                        )
                      : Container(),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 200,
                          child: MaterialButton(
                            color: CustomColors.blackK,
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MachineLearningPage(),
                                  ));
                            },
                            child: const Text(
                              'Predict Place',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.whiteK),
                            ),
                          ),
                        ),      SizedBox(
                          width: 200,
                          child: MaterialButton(
                            color: CustomColors.blackK,
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ));
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.whiteK),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
