import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final String? image;
  final VoidCallback onTap;
  const SettingsCard({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
    this.image,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: const Color(0xffEEF9FF),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
            padding: EdgeInsets.all(
                MediaQuery.of(context).size.shortestSide < 600 ? 15 : 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    image == null
                        ? Icon(
                            icon,
                            // color: const Color(0xff4DC2F8),
                            color: iconColor,
                            size: 20,
                          )
                        : SvgPicture.asset(
                            image!,
                            height: 20,
                            color: iconColor,
                          ),
                    10.horizontalSpace,
                    CustomText(
                      text: title,
                      fontSize: MediaQuery.of(context).size.shortestSide < 600
                          ? 12.0
                          : 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
