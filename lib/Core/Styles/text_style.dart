import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/Core/Colors/app_colors.dart';
import 'package:task/Core/FontManager/font_manager.dart';

class TextStyles {
  static TextStyle boldStyle = TextStyle(
      fontWeight: FontManager.bold,
      fontSize: setResponsiveFontSize(16),
      color: CustomColors.blackK);
  static TextStyle regularStyle = TextStyle(
      fontWeight: FontManager.regular,
      fontSize: setResponsiveFontSize(16),
      color: CustomColors.blackK);
  static TextStyle normalStyle = TextStyle(
      fontWeight: FontManager.normal,
      fontSize: setResponsiveFontSize(16),
      color: CustomColors.blackK);
}

setResponsiveFontSize(size) {
  return ScreenUtil().setSp(size);
}
