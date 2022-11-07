import 'package:flutter/material.dart';
import 'package:task/Core/Colors/app_colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: const Color(0x0fff4f4f).withOpacity(0.2),
        scaffoldBackgroundColor: CustomColors.whiteK,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(backgroundColor: CustomColors.whiteK),
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: CustomColors.dateTicketColorK,
        ));
  }
}
