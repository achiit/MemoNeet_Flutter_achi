// ignore_for_file: unused_local_variable, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:memo_neet/MVVM/viewmodels/mcqs/mcq_provider.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/MVVM/views/McqsView/mcqs_screen.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/practice_steps/practice_steps.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

class SubTopicCard extends StatefulWidget {
  final int index;
  const SubTopicCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _SubTopicCardState createState() => _SubTopicCardState();
}

class _SubTopicCardState extends State<SubTopicCard> {
  int percentage = 0;
  late Box<double> progressBox;
  late McqProvider mcqProvider;

  @override
  void initState() {
    super.initState();
    // progressBox = Hive.box<double>(HiveBoxName.subTopicProgress);
    mcqProvider = Provider.of<McqProvider>(context, listen: false);

    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //   await calculatePercentage();
    //   mcqProvider.progressNotifier.addListener(_updatePercentage);
    // });
  }

  // Future<void> calculatePercentage() async {
  //   if (!mounted) {
  //     return; // Check if the widget is still mounted
  //   }

  //   final totalQuestions = context
  //       .read<SubjectViewModel>()
  //       .subTopics[widget.index]
  //       .questions
  //       .length;

  //   double progress = 0.0;
  //   if (totalQuestions != null && totalQuestions > 0) {
  //     progress = mcqProvider.progressNotifier.progress / totalQuestions;
  //   }
  //   final newPercentage = progress.isFinite ? progress.toInt() : 0;

  //   if (newPercentage != percentage) {
  //     setState(() {
  //       percentage = newPercentage;
  //     });
  //     print("Percentage: $percentage");
  //   }

  //   updateProgressInHive();
  // }

  // Future<void> updateProgressInHive() async {
  //   if (!mounted) {
  //     return; // Check if the widget is still mounted
  //   }

  //   final topicNameParts = mcqProvider.questionModel?.topicName.split('>>');
  //   final subTopicName = topicNameParts?.last.trim();

  //   if (subTopicName != null) {
  //     print(
  //         "Updating progress in Hive - subTopicId: $subTopicName, percentage: $percentage");

  //     // Update the progress in Hive
  //     progressBox.put(subTopicName, percentage.toDouble());
  //     print("Progress updated in Hive.");
  //   }
  // }

  // void _updatePercentage() {
  //   final progress = mcqProvider.progressNotifier.progress;
  //   final newPercentage = progress.toInt();

  //   if (newPercentage != percentage) {
  //     if (mounted) {
  //       setState(() {
  //         percentage = newPercentage;
  //       });
  //     }
  //     print("Percentage: $percentage");

  //     // Update the progress in Hive
  //     updateProgressInHive();
  //   }
  // }

  @override
  void dispose() {
    // mcqProvider.progressNotifier.removeListener(_updatePercentage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        context.read<SubjectViewModel>().subTopics[widget.index].progressCount /
            context
                .read<SubjectViewModel>()
                .subTopics[widget.index]
                .questions
                .length *
            1);
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            context.read<SubjectViewModel>().setSelectedSubTopic(widget.index);
            PageNavigator(ctx: context).nextPage(
                page: PracticeSteps(
              subjectName: context
                  .read<SubjectViewModel>()
                  .selectedSubjectModel!
                  .subjectName,
              onPressed: () {
                Navigator.of(context).pop();
                PageNavigator(ctx: context).nextPage(page: const McqsScreen());
              },
            ));

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return
            //     },
            //   ),
            // );
          },
          child: Stack(
            children: [
              Positioned(
                bottom: 4,
                left: 1,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: AppColors.grey.withOpacity(0.0),
                      ),
                      height: 20,
                      width: (MediaQuery.of(context).size.width - 26),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: AppColors.primaryColor,
                      ),
                      height: 20,
                      width: (context
                                  .read<SubjectViewModel>()
                                  .subTopics[widget.index]
                                  .progressCount /
                              context
                                  .read<SubjectViewModel>()
                                  .subTopics[widget.index]
                                  .questions
                                  .length) *
                          (MediaQuery.of(context).size.width - 26),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFFFFFFF),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(133, 133, 133, 0.10),
                      offset: Offset(1.0, 1.0),
                      blurRadius: 44.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.only(top: 14, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                context
                                    .read<SubjectViewModel>()
                                    .subTopics[widget.index]
                                    .subTopicName,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            CustomText(
                              text:
                                  "${AppStrings.questionCovered} ${context.read<SubjectViewModel>().subTopics[widget.index].progressCount}/${context.read<SubjectViewModel>().subTopics[widget.index].questions.length}",
                              fontSize: 14.0,
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
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
