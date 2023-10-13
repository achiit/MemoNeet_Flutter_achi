import 'package:flutter/cupertino.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class TopCover extends StatelessWidget {
  final double? imageHeight;
  const TopCover({
    super.key,
    this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.doctor1,
          height: imageHeight,
        ),
        CustomText(
          text: "Hey Future Doctor!",
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
          fontSize: 32.0,
        ),
      ],
    );
  }
}
