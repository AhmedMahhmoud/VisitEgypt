import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Enums/firebase_request_enum.dart';
import 'package:visit_egypt/Features/Auth/View/register_page.dart';
import '../../../Core/Shared/SharedPreferences (Singelton)/shared_pref.dart';
import '../../../Core/Styles/text_style.dart';
import '../../bottom_navigation/bottom_navigation.dart';
import '../Model/login.dart';
import 'cubit/auth_cubit.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void initState() {
    rememberValue = Prefs.getBool("rememberMe") ?? false;
    super.initState();
  }

  setRememberMe(rememberValue) => Prefs.setBool("rememberMe", rememberValue);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) => previous == LoadingAuthState(),
          listener: (ctx, state) async {
            if (state is ErrorAuthState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMsg)));
            } else if (state is LoadedAuthState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNav(
                      comingIndex: 0,
                      firebaseRequestType: FirebaseRequestType.login,
                    ),
                  ));
            }
          },
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/bg2.jpg',
                    ),
                    fit: BoxFit.cover,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20.h,
                  ),
                  AutoSizeText(
                    'Sign In',
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
                        TextFormField(
                          controller: _email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a valid email address.";
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
                              borderRadius: BorderRadius.circular(10),
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
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CheckboxListTile(
                                title: const AutoSizeText("Remember me"),
                                contentPadding: EdgeInsets.zero,
                                value: rememberValue,
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                onChanged: (newValue) {
                                  setState(() {
                                    rememberValue = newValue!;
                                    setRememberMe(newValue);
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: TextButton(
                                  child: const AutoSizeText(
                                    "Forgot password ?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ResetPasswordPage(
                                                  title: "Reset Password"),
                                        ));
                                  },
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
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
                                      .firebaseSignIn(AuthModel(
                                          username: _email.text,
                                          password: _password.text));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 15, 40, 15),
                              ),
                              child: const AutoSizeText(
                                'Sign in',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        }),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText('Not registered yet?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                              child: const AutoSizeText(
                                'Create an account',
                                style: TextStyle(
                                  fontFamily: 'Changa',
                                ),
                              ),
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
