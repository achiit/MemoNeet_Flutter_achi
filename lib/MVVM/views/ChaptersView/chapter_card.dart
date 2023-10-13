// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/MVVM/models/subjects/chapters/chapter_model.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/navigation/navigation_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/MVVM/views/TopicView/topic_view.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/popup_dialog/custom_dialog.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ChapterCard extends StatefulWidget {
  final int index;

  const ChapterCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<ChapterCard> createState() => _ChapterCardState();
}

class _ChapterCardState extends State<ChapterCard> {
  int selectedChapterIndex = -1;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      var subjectViewModel = context.read<SubjectViewModel>();
      List<ChapterModel> chapters =
          subjectViewModel.selectedSubjectModel?.chapters ?? [];
      selectedChapterIndex = chapters.indexOf(context
          .read<SubjectViewModel>()
          .selectedSubjectModel!
          .chapters[widget.index]);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigationBarIndex = Provider.of<NavigationViewModel>(context);
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
// mobile view
      return mobileView(context, navigationBarIndex);
    } else {
      // tablet view
      return tabletView(context, navigationBarIndex);
    }
  }

  GestureDetector tabletView(
      BuildContext context, NavigationViewModel navigationBarIndex) {
    return GestureDetector(
      onTap: () async {
        if (selectedChapterIndex != -1) {
          await context
              .read<SubjectViewModel>()
              .setSelectedChapter(selectedChapterIndex);
          if (context.read<UserViewModel>().isSubscribedUser ||
              context
                  .read<SubjectViewModel>()
                  .selectedSubjectModel!
                  .chapters[widget.index]
                  .isFreeChapter) {
            PageNavigator(ctx: context).nextPage(page: const TopicView());
          } else {
            dialogForSubscription(context, providerValue: navigationBarIndex);
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF858585).withOpacity(0.1),
                offset: const Offset(1, 1),
                blurRadius: 44,
                spreadRadius: 0,
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: (context.read<UserViewModel>().isSubscribedUser ||
                            context
                                .read<SubjectViewModel>()
                                .selectedSubjectModel!
                                .chapters[widget.index]
                                .isFreeChapter)
                        ? const Color(0xff9FDEFB)
                        : const Color.fromARGB(33, 137, 137, 137),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: CircularPercentIndicator(
                    backgroundColor: Colors.transparent,
                    percent: context
                            .watch<SubjectViewModel>()
                            .selectedSubjectModel!
                            .chapters[widget.index]
                            .progressCount /
                        context
                            .watch<SubjectViewModel>()
                            .selectedSubjectModel!
                            .chapters[widget.index]
                            .numberOfQuestions,
                    progressColor: AppColors.progressColor,
                    radius: 30.0,
                    lineWidth: 30.0,
                    center: CustomText(
                      text:
                          "${((context.watch<SubjectViewModel>().selectedSubjectModel!.chapters[widget.index].numberOfQuestions == 0) ? 0 : ((context.watch<SubjectViewModel>().selectedSubjectModel!.chapters[widget.index].progressCount / context.watch<SubjectViewModel>().selectedSubjectModel!.chapters[widget.index].numberOfQuestions) * 100).toStringAsFixed(0))}%",
                      fontSize: 12.6,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context
                            .read<SubjectViewModel>()
                            .selectedSubjectModel!
                            .chapters[widget.index]
                            .chapterName,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.headingColor),
                      ),
                      4.verticalSpace,
                      CustomText(
                        text:
                            "${AppStrings.questionCovered} ${context.watch<SubjectViewModel>().selectedSubjectModel!.chapters[widget.index].progressCount}/${context.watch<SubjectViewModel>().selectedSubjectModel!.chapters[widget.index].numberOfQuestions}",
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (context.watch<UserViewModel>().isSubscribedUser ||
                context
                    .read<SubjectViewModel>()
                    .selectedSubjectModel!
                    .chapters[widget.index]
                    .isFreeChapter) ...[
              const Icon(
                FontAwesomeIcons.angleRight,
                size: 16,
              ),
            ] else
              const Icon(Icons.lock, color: Colors.red),
          ],
        ),
      ),
    );
  }

  GestureDetector mobileView(
      BuildContext context, NavigationViewModel navigationBarIndex) {
    return GestureDetector(
      onTap: () async {
        if (selectedChapterIndex != -1) {
          await context
              .read<SubjectViewModel>()
              .setSelectedChapter(selectedChapterIndex);
          if (context.read<UserViewModel>().isSubscribedUser ||
              context
                  .read<SubjectViewModel>()
                  .selectedSubjectModel!
                  .chapters[widget.index]
                  .isFreeChapter) {
            PageNavigator(ctx: context).nextPage(page: const TopicView());
          } else {
            dialogForSubscription(context, providerValue: navigationBarIndex);
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF858585).withOpacity(0.1),
                offset: const Offset(1, 1),
                blurRadius: 44,
                spreadRadius: 0,
              ),
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: (context.read<UserViewModel>().isSubscribedUser ||
                              context
                                  .read<SubjectViewModel>()
                                  .selectedSubjectModel!
                                  .chapters[widget.index]
                                  .isFreeChapter)
                          ? const Color(0xff9FDEFB)
                          : const Color.fromARGB(33, 137, 137, 137),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: CircularPercentIndicator(
                      backgroundColor: Colors.transparent,
                      percent: context
                              .watch<SubjectViewModel>()
                              .selectedSubjectModel!
                              .chapters[widget.index]
                              .progressCount /
                          context
                              .watch<SubjectViewModel>()
                              .selectedSubjectModel!
                              .chapters[widget.index]
                              .numberOfQuestions,
                      progressColor: AppColors.progressColor,
                      radius: 30.0,
                      lineWidth: 30.0,
                      center: CustomText(
                        text:
                            "${((context.watch<SubjectViewModel>().selectedSubjectModel!.chapters[widget.index].numberOfQuestions == 0) ? 0 : ((context.watch<SubjectViewModel>().selectedSubjectModel!.chapters[widget.index].progressCount / context.watch<SubjectViewModel>().selectedSubjectModel!.chapters[widget.index].numberOfQuestions) * 100).toStringAsFixed(0))}%",
                        fontSize: 12.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          context
                              .read<SubjectViewModel>()
                              .selectedSubjectModel!
                              .chapters[widget.index]
                              .chapterName,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: AppColors.headingColor),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    CustomText(
                      text:
                          "${AppStrings.questionCovered} ${context.watch<SubjectViewModel>().selectedSubjectModel!.chapters[widget.index].progressCount}/${context.watch<SubjectViewModel>().selectedSubjectModel!.chapters[widget.index].numberOfQuestions}",
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGrey,
                    ),
                  ],
                ),
              ),
            ),
            if (context.watch<UserViewModel>().isSubscribedUser ||
                context
                    .read<SubjectViewModel>()
                    .selectedSubjectModel!
                    .chapters[widget.index]
                    .isFreeChapter) ...[
              const Expanded(
                  child: Icon(
                FontAwesomeIcons.angleRight,
                size: 16,
              )),
            ] else
              const Expanded(child: Icon(Icons.lock, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
