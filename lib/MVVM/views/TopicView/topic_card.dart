// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/MVVM/views/SubTopicView/subtopic_view.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class TopicCard extends StatefulWidget {
  final int index;
  final DateTime? expiryDate;

  const TopicCard({
    Key? key,
    required this.index,
    this.expiryDate,
  }) : super(key: key);

  @override
  _TopicCardState createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  // Future<void> calculatePercentage() async {
  //   final selectedChapterModel =
  //       context.read<SubjectViewModel>().selectedChapterModel;
  //   if (selectedChapterModel == null) return;

  //   final topic = selectedChapterModel.topics[widget.index];
  //   if (topic == null) return;

  //   double totalSubtopicProgress = 0.0;
  //   subtopicProgressBox = await Hive.openBox<double>('subTopicProgress');

  //   for (final subtopic in context.read<SubjectViewModel>().subTopics) {
  //     final subtopicId = subtopic.subTopicName;
  //     final subtopicProgress = subtopicProgressBox.get(subtopicId) ?? 0;
  //     totalSubtopicProgress += subtopicProgress;
  //   }

  //   if (topic.questionCount != 0) {
  //     topicProgress = totalSubtopicProgress /
  //         context.read<SubjectViewModel>().subTopics.length;
  //   } else {
  //     topicProgress = 0.0;
  //   }

  //   topicProgressBox.put(topic.topicName, topicProgress);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return mobileView(context);
    } else {
      return tabletView(context);
    }
  }

  GestureDetector tabletView(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.read<SubjectViewModel>().setSelectedTopic(widget.index);
        PageNavigator(ctx: context).nextPage(page: const SubTopicView());
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xff9FDEFB),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: CircularPercentIndicator(
                    backgroundColor: Colors.transparent,
                    percent: (context
                                .watch<SubjectViewModel>()
                                .topics[widget.index]
                                .numberOfQuestions >
                            0)
                        ? (context
                                .watch<SubjectViewModel>()
                                .topics[widget.index]
                                .progressCount /
                            context
                                .watch<SubjectViewModel>()
                                .topics[widget.index]
                                .numberOfQuestions)
                        : 0,
                    progressColor: AppColors.progressColor,
                    radius: 30.0,
                    lineWidth: 30.0,
                    center: CustomText(
                      text:
                          "${((context.watch<SubjectViewModel>().topics[widget.index].numberOfQuestions == 0) ? 0 : ((context.watch<SubjectViewModel>().topics[widget.index].progressCount / context.watch<SubjectViewModel>().topics[widget.index].numberOfQuestions) * 100).toStringAsFixed(0))}%",
                      fontSize: 12.6,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        context
                            .read<SubjectViewModel>()
                            .topics[widget.index]
                            .topicName,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    6.verticalSpace,
                    CustomText(
                      text:
                          "${AppStrings.questionCovered} ${context.watch<SubjectViewModel>().topics[widget.index].progressCount}/${context.watch<SubjectViewModel>().topics[widget.index].numberOfQuestions}",
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGrey,
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
                child: Icon(
              FontAwesomeIcons.angleRight,
              size: 16,
            ))
          ],
        ),
      ),
    );
  }

  GestureDetector mobileView(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.read<SubjectViewModel>().setSelectedTopic(widget.index);
        PageNavigator(ctx: context).nextPage(page: const SubTopicView());
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
                      color: const Color(0xff9FDEFB),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: CircularPercentIndicator(
                      backgroundColor: Colors.transparent,
                      percent: (context
                                  .watch<SubjectViewModel>()
                                  .topics[widget.index]
                                  .numberOfQuestions >
                              0)
                          ? (context
                                  .watch<SubjectViewModel>()
                                  .topics[widget.index]
                                  .progressCount /
                              context
                                  .watch<SubjectViewModel>()
                                  .topics[widget.index]
                                  .numberOfQuestions)
                          : 0,
                      progressColor: AppColors.progressColor,
                      radius: 30.0,
                      lineWidth: 30.0,
                      center: CustomText(
                        text:
                            "${((context.watch<SubjectViewModel>().topics[widget.index].numberOfQuestions == 0) ? 0 : ((context.watch<SubjectViewModel>().topics[widget.index].progressCount / context.watch<SubjectViewModel>().topics[widget.index].numberOfQuestions) * 100).toStringAsFixed(0))}%",
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
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        context
                            .read<SubjectViewModel>()
                            .topics[widget.index]
                            .topicName,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    6.verticalSpace,
                    CustomText(
                      text:
                          "${AppStrings.questionCovered} ${context.watch<SubjectViewModel>().topics[widget.index].progressCount}/${context.watch<SubjectViewModel>().topics[widget.index].numberOfQuestions}",
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGrey,
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
                child: Icon(
              FontAwesomeIcons.angleRight,
              size: 16,
            ))
          ],
        ),
      ),
    );
  }
}
