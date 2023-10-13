import 'package:flutter/material.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class SettingsHeading extends StatelessWidget {
  final String text;
  const SettingsHeading({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: CustomText(
            text: text,
            fontWeight: FontWeight.w500,
            fontSize:
                MediaQuery.of(context).size.shortestSide < 600 ? 12.0 : 16.0,
          ),
        ),
      ],
    );
  }
}
