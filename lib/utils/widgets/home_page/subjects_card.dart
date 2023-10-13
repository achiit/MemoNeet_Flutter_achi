import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/chapters_view.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

class SubjectsCard extends StatelessWidget {
  final int index;
  const SubjectsCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return mobileView(context);
    } else {
      return tabletView(context);
    }
  }

  InkWell tabletView(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SubjectViewModel>().setSelectedSubject = index;
        PageNavigator(ctx: context).nextPage(page: const ChaptersView());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF858585).withOpacity(0.1),
              offset: const Offset(1, 1),
              blurRadius: 44,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // height: 70,
                  // width: 70,
                  margin: const EdgeInsets.only(
                    left: 20,
                    top: 12,
                    bottom: 12,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.headingColor.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: SvgPicture.asset(
                    index == 0
                        ? AppImages.bio
                        : index == 1
                            ? AppImages.chem
                            : AppImages.physics,
                    // height: MediaQuery.of(context).size.height / 13,
                  ),
                ),
                20.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: context
                          .watch<SubjectViewModel>()
                          .subjects[index]
                          .subjectName,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.headingColor,
                    ),
                    4.verticalSpace,
                    CustomText(
                      text:
                          "Total chapters: ${context.watch<SubjectViewModel>().subjects[index].chapters.length.toString()}",
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(26, 17, 45, 0.5),
                    ),
                  ],
                ),
              ],
            ),
            // Container(
            //   padding: const EdgeInsets.only(right: 20),
            //   child: Column(
            //     children: [
            //       Icon(
            //         Icons.arrow_forward_ios,
            //         color: AppColors.headingColor,
            //         size: 20,
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  InkWell mobileView(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SubjectViewModel>().setSelectedSubject = index;
        PageNavigator(ctx: context).nextPage(page: const ChaptersView());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF858585).withOpacity(0.1),
              offset: const Offset(1, 1),
              blurRadius: 44,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(
                    left: 20,
                    top: 12,
                    bottom: 12,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.headingColor.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: SvgPicture.asset(index == 0
                      ? AppImages.bio
                      : index == 1
                          ? AppImages.chem
                          : AppImages.physics),
                ),
                20.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: context
                          .watch<SubjectViewModel>()
                          .subjects[index]
                          .subjectName,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.headingColor,
                    ),
                    4.verticalSpace,
                    CustomText(
                      text:
                          "Total chapters: ${context.watch<SubjectViewModel>().subjects[index].chapters.length.toString()}",
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(26, 17, 45, 0.5),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.headingColor,
                    size: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
