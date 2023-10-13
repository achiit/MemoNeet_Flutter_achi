// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/revisionmodel/revision_view_model.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/revision/how_revision_works.dart';
import 'package:memo_neet/MVVM/views/McqsView/mcqs_screen.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/repo/revision_service.dart';
import 'package:memo_neet/utils/helpers/revision_data.dart';
import 'package:memo_neet/utils/widgets/Revision/revision_screen_tile.dart';
import 'package:memo_neet/utils/widgets/loader/loader.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/subject/subject_view_model.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  RevisionViewModel revisionViewModel = RevisionViewModel();

  var subject;

  Map<int, bool> enbaleRevisionTestSequence = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      revisionViewModel =
          Provider.of<RevisionViewModel>(context, listen: false);
      subject =
          Provider.of<SubjectViewModel>(context, listen: false).selectedSubject;
      revisionViewModel.getQuestionsCountByLevel(subject).then((result) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return (context.watch<RevisionViewModel>().isLoading)
          ? const Center(
              child: Loader(),
            )
          : mobileView(context);
    } else {
      return (context.watch<RevisionViewModel>().isLoading)
          ? const Center(
              child: Loader(),
            )
          : tabletView(context);
    }
  }

  SingleChildScrollView tabletView(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                PageNavigator(ctx: context)
                    .nextPage(page: const HowRevisionWorks());
              },
              child: Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.info_outline,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const CustomText(
                      text: "How Memoneet revision algorithm works?",
                      fontSize: 12.0,
                    ),
                  ],
                ),
              ),
            ),
            16.verticalSpace,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 6,
                crossAxisCount:
                    3, // Set the number of columns you want in the grid
              ),
              itemCount: levelTitles.length,
              itemBuilder: (ctx, index) {
                // Get the total questions for the current level (index)
                int revisionViewModelForLevel =
                    revisionViewModel.questionsByLevel[index] ?? 0;

                return RevisionTile(
                  onLongPress: () {
                    if (context.read<RevisionService>().isTestMode) {
                      showSnackBar(
                        context: context,
                        message: "Revision Test is already enabled",
                      );
                      return;
                    }
                    enbaleRevisionTestSequence[index] = true;
                    if (enbaleRevisionTestSequence.values
                        .every((element) => element == true)) {
                      context.read<RevisionService>().isTestMode = true;
                      showSnackBar(
                        context: context,
                        message: "Revision Test Enabled",
                      );
                    }
                  },
                  ontap: () async {
                    context.read<SubjectViewModel>().setCurrentRevisionLevel =
                        index;
                    context.read<SubjectViewModel>().isRevision = true;
                    await context
                        .read<SubjectViewModel>()
                        .getRevisionQuestions();

                    // Check if there are questions available for the selected level
                    if (context.read<SubjectViewModel>().questions.isEmpty) {
                      showSnackBar(
                        context: context,
                        message: "The module is empty",
                      );
                    } else {
                      PageNavigator(ctx: context)
                          .nextPage(page: const McqsScreen());
                    }
                  },
                  total_questions:
                      " $revisionViewModelForLevel", // Show the total questions for the current level
                  imagePath: imagesData[index],
                  text: levelTitles[index],
                );
              },
            ),
            CompletedQuestionTile(
              backgroundColor: AppColors.darkGreen,
              text: "Completed Questions",
              total_questions:
                  '${revisionViewModel.completedQuestionCount}/${revisionViewModel.completedQuestionCount + revisionViewModel.pendingQuestionCount}',
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView mobileView(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                PageNavigator(ctx: context)
                    .nextPage(page: const HowRevisionWorks());
              },
              child: Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.info_outline,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const CustomText(
                      text: "How Memoneet revision algorithm works?",
                      fontSize: 12.0,
                    ),
                  ],
                ),
              ),
            ),
            16.verticalSpace,
            CompletedQuestionTile(
              backgroundColor: AppColors.darkGreen,
              text: "Completed Questions",
              total_questions:
                  '${revisionViewModel.completedQuestionCount}/${revisionViewModel.completedQuestionCount + revisionViewModel.pendingQuestionCount}',
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: levelTitles.length,
              itemBuilder: (ctx, index) {
                // Get the total questions for the current level (index)

                int revisionViewModelForLevel =
                    revisionViewModel.questionsByLevel[index] ?? 0;

                return RevisionTile(
                  onLongPress: () {
                    if (context.read<RevisionService>().isTestMode) {
                      showSnackBar(
                        context: context,
                        message: "Revision Test is already enabled",
                      );
                      return;
                    }
                    enbaleRevisionTestSequence[index] = true;
                    if (enbaleRevisionTestSequence.values
                        .every((element) => element == true)) {
                      context.read<RevisionService>().isTestMode = true;
                      showSnackBar(
                        context: context,
                        message: "Revision Test Enabled",
                      );
                    }
                  },
                  ontap: () async {
                    context.read<SubjectViewModel>().setCurrentRevisionLevel =
                        index;
                    context.read<SubjectViewModel>().isRevision = true;
                    await context
                        .read<SubjectViewModel>()
                        .getRevisionQuestions();

                    // Check if there are questions available for the selected level
                    if (context.read<SubjectViewModel>().questions.isEmpty) {
                      showSnackBar(
                        context: context,
                        message: "The module is empty",
                      );
                    } else {
                      PageNavigator(ctx: context)
                          .nextPage(page: const McqsScreen());
                    }
                  },
                  total_questions:
                      " $revisionViewModelForLevel", // Show the total questions for the current level
                  imagePath: imagesData[index],
                  text: levelTitles[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
