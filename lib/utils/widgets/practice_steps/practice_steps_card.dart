import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class PracticeStepsCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String stepsNumber;
  const PracticeStepsCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.stepsNumber,
  });

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return mobileView();
    } else {
      return tabletView(context);
    }
  }

  Stack tabletView(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.09,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      70.verticalSpace,
                      CustomText(
                        text: title,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      // 20.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Positioned(
                left: 22,
                child: SvgPicture.asset(
                  imageUrl,
                  height: 120,
                )),
          ],
        ),
      ],
    );
  }

  Stack mobileView() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: 130,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  50.verticalSpace,
                  CustomText(
                    text: title,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(left: 22, child: SvgPicture.asset(imageUrl)),
      ],
    );
  }
}
