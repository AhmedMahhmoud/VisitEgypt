import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Colors/app_colors.dart';
import '../../../../Core/Styles/text_style.dart';

class LoadingPostWidget extends StatelessWidget {
  const LoadingPostWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: TextStyles.boldStyle.copyWith(
                color: CustomColors.greyK.withOpacity(0.7), fontSize: 17),
            child: AnimatedTextKit(
              repeatForever: false,
              totalRepeatCount: 1,
              animatedTexts: [
                TyperAnimatedText(
                    speed: const Duration(milliseconds: 100),
                    'Your post is uploading now ...'),
                TyperAnimatedText(
                    speed: const Duration(milliseconds: 100),
                    'Please wait ...'),
                TyperAnimatedText(
                    speed: const Duration(milliseconds: 100),
                    'Almost  done ...'),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
