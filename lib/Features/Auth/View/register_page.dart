import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Enums/firebase_request_enum.dart';
import 'package:visit_egypt/Enums/user_type.dart';

import '../../../Core/Styles/text_style.dart';
import '../../bottom_navigation/bottom_navigation.dart';
import '../Model/login.dart';
import 'cubit/auth_cubit.dart';
import 'login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/user_type_radio.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String userType = "tourist";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (ctx, state) {
            if (state is ErrorAuthState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMsg)));
            } else if (state is LoadedAuthState) {
              log("state loaded: ${state.userCredential.user}");

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNav(
                      comingIndex: 0,
                      firebaseRequestType: FirebaseRequestType.register,
                    ),
                  ));
            }
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/bg2.jpg',
                    ),
                    fit: BoxFit.cover,
                  )),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    'Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Changa',
                      fontSize: setResponsiveFontSize(40),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          controller: _email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter an email";
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: '  Enter your email',
                            prefixIcon: Image.asset(
                              'assets/images/maill.png',
                              height: 30.h,
                              width: 30.w,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          controller: _password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          maxLines: 1,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              'assets/images/pass.png',
                              height: 30.h,
                              width: 30.w,
                            ),
                            hintText: '  Enter your password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText(
                                "Sign up as :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              UserTypeRadio(
                                callBackFun: (v) {
                                  userType = v;
                                },
                              )
                            ]),
                        BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                          if (state is LoadingAuthState) {
                            return const CircularProgressIndicator();
                          } else {
                            return ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthCubit>(context,
                                      listen: false)
                                    ..firebaseSignUp(
                                        AuthModel(
                                            username: _email.text,
                                            password: _password.text),
                                        userType)
                                    ..userTypeEnum = userType == 'tourist'
                                        ? UserTypeEnum.tourist
                                        : UserTypeEnum.tourguide;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 15, 40, 15),
                              ),
                              child: const AutoSizeText(
                                'Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        }),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText('Already registered?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: const AutoSizeText('Sign in',
                                  style: TextStyle(
                                    fontFamily: 'Changa',
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
