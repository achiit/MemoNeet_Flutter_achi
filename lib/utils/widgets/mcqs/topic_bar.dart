import 'package:flutter/material.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class TopicBar extends StatelessWidget {
  final String unitName;

  const TopicBar({
    super.key,
    required this.unitName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomText(
        text: unitName,
        textAlign: TextAlign.start,
        maxLines: 3,
        fontWeight: FontWeight.w400,
        fontSize: 10.0,
      ),
    );
  }
}
