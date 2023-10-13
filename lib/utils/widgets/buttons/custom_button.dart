import 'package:flutter/material.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final dynamic borderRadius;
  final double? fontSize;
  final IconData? icon;
  final String? image;
  final double? imageSize;
  final Color? iconColor;
  const CustomButton({
    super.key,
    required this.buttonText,
    this.backgroundColor,
    required this.onPressed,
    this.borderRadius,
    this.fontSize,
    this.icon,
    this.iconColor,
    this.image,
    this.textColor,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: backgroundColor,
          side: BorderSide(color: AppColors.textBlack, width: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  image == null
                      ? Icon(
                          icon,
                          color: iconColor,
                        )
                      : Image.asset(
                          image!,
                          scale: imageSize,
                        ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: buttonText,
                    fontSize: fontSize ?? 14.0,
                    color: textColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
