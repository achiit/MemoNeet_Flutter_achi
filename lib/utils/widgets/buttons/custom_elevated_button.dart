import 'package:flutter/material.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
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
  final double? elevation;
  final double? iconSize;
  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    this.backgroundColor,
    required this.onPressed,
    this.borderRadius,
    this.fontSize,
    this.elevation,
    this.icon,
    this.iconColor,
    this.image,
    this.textColor,
    this.imageSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: elevation,
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* SizedBox(
              width: 40,
            ), */
            Column(
              children: [
                image == null
                    ? Icon(
                        icon,
                        color: iconColor,
                        size: iconSize,
                      )
                    : Image.asset(
                        image!,
                        scale: imageSize,
                      ),
              ],
            ),
            5.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: buttonText,
                  fontSize: fontSize ?? 14.0,
                  color: textColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
