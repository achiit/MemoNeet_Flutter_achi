import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/MVVM/views/McqsView/mcqs_screen.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/practice_steps/practice_steps.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class SubTopicScreen extends StatelessWidget {
  const SubTopicScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            {
              PageNavigator(ctx: context).nextPage(
                  page: PracticeSteps(
                subjectName: "Biology",
                onPressed: () {
                  PageNavigator(ctx: context)
                      .nextPage(page: const McqsScreen());
                },
              ));
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.only(left: 10, right: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        right: 10, left: 20, top: 30, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: "Subtopic",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  maxLines: 2,
                                ),
                                6.verticalSpace,
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: CustomText(
                                    text: "Total Questions : 0/1",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGrey,
                                  ),
                                )
                              ],
                            )),
                        const Expanded(
                          child: Icon(
                            FontAwesomeIcons.angleRight,
                          ),
                        )
                      ],
                    ),
                  ),
                  LinearProgressIndicator(
                    minHeight: 10,
                    backgroundColor: AppColors.bgGrey,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                    value: 0.25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
