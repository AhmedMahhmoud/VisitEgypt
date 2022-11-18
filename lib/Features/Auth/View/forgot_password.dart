import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/Shared/methods.dart';
import '../Model/login.dart';
import 'cubit/auth_cubit.dart';
import 'login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ResetPasswordPage({required this.title}) : super();
  final String title;
  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous == LoadingForgetPasswordState(),
        listener: (ctx, state) {
          log(state.toString());
          if (state is ErrorAuthState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
          if (state is LoadedForgetPasswordState) {
            ConstantMethods.showContentToast(context,
                "Password reseted successfully !\n Please check your email");
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Enter the email address associated with your account.',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    TextField(
                      controller: _emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    const SizedBox(height: 40.0),
                    BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                      if (state is LoadingForgetPasswordState) {
                        return const CircularProgressIndicator();
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            if (_emailAddress.text.isEmpty ||
                                !_emailAddress.text.contains("@") ||
                                !_emailAddress.text.contains(".com")) {
                              ConstantMethods.showContentToast(context,
                                  "Please enter a valid email address", true);
                            } else {
                              await context
                                  .read<AuthCubit>()
                                  .firebaseResetPassword(AuthModel(
                                      username: _emailAddress.text,
                                      password: ''));
                            }
                          },
                          child: SizedBox(
                            height: 40.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.blueAccent,
                              color: Colors.blue,
                              elevation: 7.0,
                              child: const Center(
                                  child: Text(
                                'RESET PASSWORD',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                            ),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
