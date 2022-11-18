import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


import '../../../Core/Shared/SharedPreferences (Singelton)/shared_pref.dart';
import '../../../Core/Styles/text_style.dart';
import '../../Auth/Model/login.dart';
import '../../Auth/View/cubit/auth_cubit.dart';
import '../../Auth/View/login_page.dart';
import '../../Home/View/homepage.dart';
import '../../bottom_navigation/bottom_navigatio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animationValue;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animationValue = Tween(begin: 1.0, end: 0.5).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    displaySplashTime();
  }

  bool isPasswordRemembered = Prefs.getBool("rememberMe") ?? false;
  displaySplashTime() async {
    _animationController.forward();

    if (isPasswordRemembered) {
      final List<String> userData = Prefs.getStringList("userData")!;
      await BlocProvider.of<AuthCubit>(context).firebaseSignIn(
          AuthModel(username: userData[0], password: userData[1]));
      // await Future.delayed(const Duration(seconds: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            opacity: animationValue.value,
                            image: const AssetImage(
                              "assets/images/splash.jpg",
                            ),
                            fit: BoxFit.fill))),
                animationValue.value < 0.6
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ZoomIn(
                            duration: const Duration(seconds: 1),
                            child: Container(
                              width: 200.w,
                              height: 200.h,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      opacity: 0.9,
                                      image: AssetImage(
                                        "assets/images/sphinx.png",
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          animationValue.value == 0.5
                              ? FadeIn(
                                  delay: const Duration(milliseconds: 300),
                                  duration: const Duration(seconds: 2),
                                  child: SizedBox(
                                      child: Center(
                                    child: DefaultTextStyle(
                                      style: TextStyles.boldStyle.copyWith(
                                          color: Colors.white, fontSize: 30),
                                      child: AnimatedTextKit(
                                        repeatForever: false,
                                        totalRepeatCount: 1,
                                        onFinished: () async {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    isPasswordRemembered
                                                        ? BottomNav(comingIndex: 0,)
                                                        : const LoginPage(),
                                              ));
                                        },
                                        animatedTexts: [
                                          TyperAnimatedText(
                                              'Add application name here'),
                                        ],
                                      ),
                                    ),
                                  )),
                                )
                              : Container(),
                        ],
                      )
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }
}
