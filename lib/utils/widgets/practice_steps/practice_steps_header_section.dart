import 'package:flutter/material.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/utils/widgets/practice_steps/practice_steps_card.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

// header section for practice steps
class PracticeStepsHeaderSection extends StatelessWidget {
  final String subjectName;
  const PracticeStepsHeaderSection({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return mobileView();
    } else {
      return tabletView(context);
    }
  }

  Column tabletView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: "How to use MemoNeet in a best way to get",
          fontSize: 25.0,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          text: "360/360 in $subjectName",
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
        30.verticalSpace,
        const CustomText(
          text: "Please read the following steps",
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Color(0xff8D8896),
        ),
        Row(
          children: [
            const CustomText(
              text: "(Hit ",
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff8D8896),
            ),
            CustomText(
              text: "start ",
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
            const CustomText(
              text: "when you did)",
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff8D8896),
            ),
          ],
        ),
        30.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color(0xffFFFFFF),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: PracticeStepsCard(
                              title: "Read paragraph",
                              imageUrl: AppImages.practice1,
                              stepsNumber: "Step 1",
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: PracticeStepsCard(
                              title: "Select Option",
                              imageUrl: AppImages.practice2,
                              stepsNumber: "Step 2",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: PracticeStepsCard(
                              title: "Read paragraph",
                              imageUrl: AppImages.practice3,
                              stepsNumber: "Step 3",
                            ),
                          ),
                          Expanded(
                            child: PracticeStepsCard(
                              title: "Select Option",
                              imageUrl: AppImages.practice4,
                              stepsNumber: "Step 4",
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column mobileView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: "How to use MemoNeet in a best way to get",
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          text: "360/360 in $subjectName",
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
        30.verticalSpace,
        const CustomText(
          text: "Please read the following steps",
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: Color(0xff8D8896),
        ),
        Row(
          children: [
            const CustomText(
              text: "(Hit ",
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff8D8896),
            ),
            CustomText(
              text: "start ",
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
            const CustomText(
              text: "when you did)",
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff8D8896),
            ),
          ],
        ),
        30.verticalSpace,
        Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: const Color(0xffFFFFFF),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: PracticeStepsCard(
                        title: "Read paragraph",
                        imageUrl: AppImages.practice1,
                        stepsNumber: "Step 1",
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: PracticeStepsCard(
                        title: "Select Option",
                        imageUrl: AppImages.practice2,
                        stepsNumber: "Step 2",
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: PracticeStepsCard(
                        title: "Read paragraph",
                        imageUrl: AppImages.practice3,
                        stepsNumber: "Step 3",
                      ),
                    ),
                    Expanded(
                      child: PracticeStepsCard(
                        title: "Select Option",
                        imageUrl: AppImages.practice4,
                        stepsNumber: "Step 4",
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
