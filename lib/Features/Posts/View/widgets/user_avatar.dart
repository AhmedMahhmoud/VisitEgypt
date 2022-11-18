import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Colors/app_colors.dart';

class UserAvatar extends StatelessWidget {
  final String username;
  const UserAvatar({
    Key? key, required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      radius: 25,
      backgroundColor:
      CustomColors.niceBlue,
      child: AutoSizeText(
        username,
        style: const TextStyle(
            color: Colors.white,
            fontWeight:
            FontWeight.bold),
      ),
    );
  }
}
