import 'package:flutter/material.dart';
// ignore_for_file: unnecessary_question_mark

import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class MyElevatedButton extends StatelessWidget {
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final String buttonText;
  final dynamic? borderRadius;
  const MyElevatedButton(
      {super.key,
      this.borderRadius,
      required this.buttonText,
      this.backgroundColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10)),
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          minimumSize: Size(double.infinity,
              MediaQuery.of(context).size.shortestSide < 600 ? 50 : 70)),
      onPressed: onPressed,
      child: CustomText(
        text: buttonText,
        color: AppColors.white,
      ),
    );
  }
}
