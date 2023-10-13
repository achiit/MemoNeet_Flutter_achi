import 'package:flutter/material.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class PlansHeading extends StatelessWidget {
  final String title;
  const PlansHeading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: AppColors.bgCardBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: title,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
