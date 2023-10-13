// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/models/mcq/mcq_menu.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:memo_neet/MVVM/views/McqsView/mcq_types/fillup_type.dart';
import 'package:memo_neet/MVVM/views/McqsView/mcq_types/match_type.dart';
import 'package:memo_neet/MVVM/viewmodels/mcqs/mcq_provider.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/MVVM/views/McqsView/mcq_types/mcq_option.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/constants/shared_prefs_helper.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/repo/revision_service.dart';
import 'package:memo_neet/utils/widgets/buttons/mcqs_navigation_button.dart';
import 'package:memo_neet/utils/widgets/loader/loader.dart';
import 'package:memo_neet/utils/widgets/mcqs/anwer_sheet.dart';
import 'package:memo_neet/utils/widgets/mcqs/diagram/diagram_widget.dart';
import 'package:memo_neet/utils/widgets/mcqs/question_bar.dart';
import 'package:memo_neet/utils/widgets/mcqs/topic_bar.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';

import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mcq_types/play_youtube_video.dart';

class McqsScreen extends StatefulWidget {
  static const route = '/mcqs-view';
  const McqsScreen({Key? key}) : super(key: key);

  @override
  State<McqsScreen> createState() => _McqsScreenState();
}

class _McqsScreenState extends State<McqsScreen> {
  PageController pageController = PageController();
  TextEditingController questionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var mcqProvider = Provider.of<McqProvider>(context, listen: false);
      mcqProvider.setCurrentQuestionIndex = 0;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<McqProvider>(builder: (context, qVm, _) {
      late final List<QuestionModel> mcqData;
      late final QuestionModel question;
      var mcqProvider = Provider.of<McqProvider>(context, listen: false);
      if (context.watch<SubjectViewModel>().questions.isNotEmpty) {
        mcqData = context.read<SubjectViewModel>().questions;
        question = mcqData[mcqProvider.currentQuestionIndex];
        mcqProvider.shuffleOptionsIfNeeded(question);
      }
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: (context.watch<SubjectViewModel>().questions.isEmpty)
              ? AppBar(
                  leading: InkWell(
                    onTap: () {
                      context.read<McqProvider>().setSelectedMcqAnswer = '';
                      mcqProvider.setCurrentQuestionIndex = 0;

                      Navigator.pop(context);
                      Navigator.pop(context);

                      Navigator.pop(context);
                    },
                    child: const Icon(FontAwesomeIcons.angleLeft),
                  ),
                  elevation: 0,
                  backgroundColor: AppColors.white,
                  iconTheme: IconThemeData(color: AppColors.black),
                  title: const Text(AppStrings.gotToTopics))
              : mcqData[mcqProvider.currentQuestionIndex].quizType ==
                          AppStrings.video &&
                      MediaQuery.of(context).orientation ==
                          Orientation.landscape
                  ? null
                  : appBarView(context, mcqProvider, mcqData),
          body: (context.watch<SubjectViewModel>().isLoading)
              ? const Center(
                  child: Loader(),
                )
              : (context.watch<SubjectViewModel>().questions.isEmpty)
                  ? Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.3),
                            child: const Text(
                              AppStrings.nothingHere,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            AppImages.notFoundDog,
                          ),
                        )
                      ],
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: PageView(
                        // physics: const ClampingScrollPhysics(),
                        controller: pageController,
                        children: List.generate(
                          context.read<SubjectViewModel>().questions.length,
                          (index) {
                            return ListView(children: [
                              topicNameAndPopupMenu(
                                  mcqData, index, context, mcqProvider),
                              progressBar(mcqProvider, mcqData),
                              10.verticalSpace,
                              questionBar(question, mcqData, mcqProvider),
                              50.verticalSpace,
                              mcqData[mcqProvider.currentQuestionIndex]
                                      .question
                                      .toString()
                                      .contains(AppStrings.diagram)
                                  ? DiagramWidget(
                                      question: mcqData[
                                              mcqProvider.currentQuestionIndex]
                                          .question,
                                    )
                                  : const SizedBox(),
                              mcqData[mcqProvider.currentQuestionIndex]
                                          .quizType ==
                                      AppStrings.mcq
                                  ? mcqTypeView(mcqData, mcqProvider, context)
                                  : mcqData[mcqProvider.currentQuestionIndex]
                                              .quizType ==
                                          AppStrings.match
                                      ? MatchTypeView(
                                          currentQuestionIndex:
                                              mcqProvider.currentQuestionIndex,
                                          mcq: mcqData,
                                        )
                                      : mcqData[mcqProvider
                                                      .currentQuestionIndex]
                                                  .quizType ==
                                              AppStrings.fillup
                                          ? FillUpType(
                                              currentQuestionIndex: mcqProvider
                                                  .currentQuestionIndex,
                                              mcq: mcqData,
                                            )
                                          : mcqData[mcqProvider
                                                          .currentQuestionIndex]
                                                      .quizType ==
                                                  AppStrings.flashCard
                                              ? flashCardView(mcqData, index)
                                              : mcqData[mcqProvider
                                                              .currentQuestionIndex]
                                                          .quizType ==
                                                      AppStrings.video
                                                  ? PlayVideoFromYoutube(
                                                      videoId: mcqData[mcqProvider
                                                              .currentQuestionIndex]
                                                          .question,
                                                    )
                                                  : mcqData[mcqProvider
                                                                  .currentQuestionIndex]
                                                              .quizType ==
                                                          AppStrings.order
                                                      ? MatchTypeView(
                                                          currentQuestionIndex:
                                                              mcqProvider
                                                                  .currentQuestionIndex,
                                                          mcq: mcqData,
                                                        )
                                                      : const SizedBox(),
                            ]);
                          },
                        ),
                        onPageChanged: (index) {
                          setState(() {
                            var qVm = Provider.of<McqProvider>(context,
                                listen: false);

                            qVm.checkResult = false;
                            context.read<McqProvider>().setSelectedMcqAnswer =
                                "";
                            mcqProvider.setCurrentQuestionIndex = index;
                          });
                        },
                      ),
                    ),
          bottomNavigationBar: (context
                  .watch<SubjectViewModel>()
                  .questions
                  .isEmpty)
              ? null
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    mcqData[mcqProvider.currentQuestionIndex].quizType ==
                                AppStrings.flashCard ||
                            mcqData[mcqProvider.currentQuestionIndex]
                                    .quizType ==
                                AppStrings.notes
                        ? backAndForwardButton(context, mcqProvider)
                        : mcqData[mcqProvider.currentQuestionIndex].quizType ==
                                AppStrings.video
                            ? const SizedBox()
                            : navigationButtonView(
                                mcqData, mcqProvider, context),
                  ],
                ));
    });
    // });
  }

  Container backAndForwardButton(
      BuildContext context, McqProvider mcqProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () {
          var qVm = Provider.of<McqProvider>(context, listen: false);

          qVm.checkResult = false;
          mcqProvider.increaseIndex();
          pageController.jumpToPage(mcqProvider.currentQuestionIndex);
        },
        child: CustomText(
          text: AppStrings.next,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget navigationButtonView(List<QuestionModel> mcqData,
      McqProvider mcqProvider, BuildContext context) {
    return McqsNavigationButtons(
      totalLength: mcqData.length,
      nextButton: () {
        mcqProvider.increaseIndex();
        pageController.jumpToPage(mcqProvider.currentQuestionIndex);
      },
      previousButton: () {
        var qVm = Provider.of<McqProvider>(context, listen: false);

        qVm.checkResult = false;
        mcqProvider.decreaseIndex();
        pageController.jumpToPage(mcqProvider.currentQuestionIndex);
      },
      currentQuestionIndex: mcqProvider.currentQuestionIndex,
      checkButtonPress: () async {
        // for mcq
        final revisionService =
            Provider.of<RevisionService>(context, listen: false);
        final question = mcqData[mcqProvider.currentQuestionIndex];
        context
            .read<SubjectViewModel>()
            .incrementCompletedQuestionCount(question.uniqueId);
        revisionService.storeRevisionQuestion(
            context.read<SubjectViewModel>().selectedSubject.toString(),
            question);
        if (mcqData[mcqProvider.currentQuestionIndex].quizType ==
            AppStrings.mcq) {
          mcqProvider.checkResult = true;
          if (context.read<McqProvider>().selectedMcqAnswer == "") {
            mcqProvider.checkResult = false;
            showSnackBar(context: context, message: AppStrings.selectAnOption);
          } else {
            mcqProvider.checkAnswer(mcqData);
            if (context.read<SubjectViewModel>().isRevision) {
              if (context.read<McqProvider>().selectedMcqAnswer ==
                  context.read<McqProvider>().correctOption) {
                context.read<RevisionService>().updateQuestionLevel(
                    context.read<SubjectViewModel>().selectedSubject,
                    mcqData[mcqProvider.currentQuestionIndex]);
              } else {
                context.read<RevisionService>().updateQuestionTime(
                    context.read<SubjectViewModel>().selectedSubject,
                    mcqData[mcqProvider.currentQuestionIndex]);
              }
            }

            showBottomSheetWithAnswer(
                context, pageController, mcqProvider, mcqData);
          }
        }
        // for match
        else if (mcqData[mcqProvider.currentQuestionIndex].quizType ==
                AppStrings.match ||
            mcqData[mcqProvider.currentQuestionIndex].quizType ==
                AppStrings.order) {
          mcqProvider.checkResult = true;

          String userOptionA = mcqProvider.mcqOptions.isNotEmpty &&
                  mcqProvider.dropList.isNotEmpty
              ? "${mcqProvider.mcqOptions[0]},${mcqProvider.dropList.isNotEmpty ? mcqProvider.dropList[0] : ''}"
              : '';
          String userOptionB = mcqProvider.mcqOptions.length > 1 &&
                  mcqProvider.dropList.length > 1
              ? "${mcqProvider.mcqOptions[1]},${mcqProvider.dropList[1]}"
              : '';
          String userOptionC = mcqProvider.mcqOptions.length > 2 &&
                  mcqProvider.dropList.length > 2
              ? "${mcqProvider.mcqOptions[2]},${mcqProvider.dropList[2]}"
              : '';
          String userOptionD = mcqProvider.mcqOptions.length > 3 &&
                  mcqProvider.dropList.length > 3
              ? "${mcqProvider.mcqOptions[3]},${mcqProvider.dropList[3]}"
              : '';

          if (mcqProvider.dropList.every((element) => element == "")) {
            showSnackBar(context: context, message: AppStrings.selectAnOption);
          } else if (userOptionA ==
                  mcqData[mcqProvider.currentQuestionIndex]
                      .optionA
                      .toString() &&
              userOptionB ==
                  mcqData[mcqProvider.currentQuestionIndex]
                      .optionB
                      .toString() &&
              userOptionC ==
                  mcqData[mcqProvider.currentQuestionIndex]
                      .optionC
                      .toString() &&
              userOptionD ==
                  mcqData[mcqProvider.currentQuestionIndex]
                      .optionD
                      .toString()) {
            showBottomSheetForMatchAndFillupType(
              context,
              mcqData,
              pageController,
              mcqProvider.currentQuestionIndex,
              mcqProvider,
              true,
              false,
            );
          } else {
            showBottomSheetForMatchAndFillupType(
              context,
              mcqData,
              pageController,
              mcqProvider.currentQuestionIndex,
              mcqProvider,
              false,
              false,
            );
          }
        } else {
          if (mcqProvider.fillUpList.isEmpty) {
            showSnackBar(context: context, message: AppStrings.selectAnOption);
          } else {
            String fillUpAnswer = "";
            mcqProvider.fillUpList.forEach(
              (element) {
                fillUpAnswer = fillUpAnswer + element;
              },
            );

            if (fillUpAnswer.toLowerCase() ==
                mcqData[mcqProvider.currentQuestionIndex]
                    .answer
                    .toString()
                    .toLowerCase()) {
              showBottomSheetForMatchAndFillupType(
                context,
                mcqData,
                pageController,
                mcqProvider.currentQuestionIndex,
                mcqProvider,
                true,
                false,
              );
            } else {
              showBottomSheetForMatchAndFillupType(
                context,
                mcqData,
                pageController,
                mcqProvider.currentQuestionIndex,
                mcqProvider,
                false,
                false,
              );
            }
          }
        }
      },
    );
  }

  Card flashCardView(List<QuestionModel> mcqData, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: CustomText(
          text: mcqData[index].question,
        ),
      ),
    );
  }

  Widget mcqTypeView(List<QuestionModel> mcqData, McqProvider mcqProvider,
      BuildContext context) {
    return Column(
      // physics: const NeverScrollableScrollPhysics(),
      children: [
        // for option A
        mcqData[mcqProvider.currentQuestionIndex].optionA.isNotEmpty
            ? McqOption(
                leadingTitle: AppStrings.a,
                optionTitle: mcqProvider.shuffledOptions[0],
                isSelected: context.read<McqProvider>().selectedMcqAnswer ==
                    AppStrings.a,
                onPressed: () {
                  setState(() {
                    context.read<McqProvider>().setSelectedMcqAnswer =
                        AppStrings.a;
                    mcqProvider.setQuestionModel =
                        mcqData[mcqProvider.currentQuestionIndex];
                  });
                },
              )
            : const SizedBox(),
        // for option B
        mcqData[mcqProvider.currentQuestionIndex].optionB.isNotEmpty
            ? McqOption(
                leadingTitle: AppStrings.b,
                optionTitle: mcqProvider.shuffledOptions[1],
                isSelected: context.read<McqProvider>().selectedMcqAnswer ==
                    AppStrings.b,
                onPressed: () {
                  setState(() {
                    context.read<McqProvider>().setSelectedMcqAnswer =
                        AppStrings.b;
                    mcqProvider.setQuestionModel =
                        mcqData[mcqProvider.currentQuestionIndex];
                  });
                },
              )
            : const SizedBox(),
        // for option C
        mcqData[mcqProvider.currentQuestionIndex].optionC.isNotEmpty
            ? McqOption(
                leadingTitle: AppStrings.c,
                optionTitle: mcqProvider.shuffledOptions[2],
                isSelected: context.read<McqProvider>().selectedMcqAnswer ==
                    AppStrings.c,
                onPressed: () {
                  setState(() {
                    context.read<McqProvider>().setSelectedMcqAnswer =
                        AppStrings.c;
                    mcqProvider.setQuestionModel =
                        mcqData[mcqProvider.currentQuestionIndex];
                  });
                },
              )
            : const SizedBox(),
        // for option D
        mcqData[mcqProvider.currentQuestionIndex].optionD.isNotEmpty
            ? McqOption(
                leadingTitle: AppStrings.d,
                optionTitle: mcqProvider.shuffledOptions[3],
                isSelected: context.read<McqProvider>().selectedMcqAnswer ==
                    AppStrings.d,
                onPressed: () {
                  setState(() {
                    context.read<McqProvider>().setSelectedMcqAnswer =
                        AppStrings.d;
                    mcqProvider.setQuestionModel =
                        mcqData[mcqProvider.currentQuestionIndex];
                  });
                },
              )
            : const SizedBox(),
      ],
    );
  }

  QuestionBar questionBar(QuestionModel question, List<QuestionModel> mcqData,
      McqProvider mcqProvider) {
    return QuestionBar(
        question: question,
        questionTitle: mcqData[mcqProvider.currentQuestionIndex].quizType ==
                AppStrings.video
            ? "${mcqProvider.currentQuestionIndex + 1}."
            : mcqData[mcqProvider.currentQuestionIndex]
                    .question
                    .toString()
                    .contains(AppStrings.diagram)
                ? mcqData[mcqProvider.currentQuestionIndex]
                    .question
                    .replaceAll(RegExp(r'\s*\(\d+\)$'), '')
                : mcqData[mcqProvider.currentQuestionIndex].question);
  }

  ClipRRect progressBar(McqProvider mcqProvider, List<QuestionModel> mcqData) {
    return ClipRRect(
      child: LinearProgressIndicator(
        minHeight: 3,
        backgroundColor: AppColors.bgGrey,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        value: (mcqProvider.currentQuestionIndex + 1) / mcqData.length,
      ),
    );
  }

  Row topicNameAndPopupMenu(List<QuestionModel> mcqData, int index,
      BuildContext context, McqProvider mcqProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: TopicBar(
                  unitName: mcqData[index].topicName,
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton<McqMenu>(
          icon: Icon(
            Icons.more_vert,
            color: AppColors.primaryColor,
          ),
          itemBuilder: (context) => [
            ...McqMenuItems.items.map(buildItem).toList(),
          ],
          onSelected: (item) => onSelected(context, item, mcqData, mcqProvider),
        ),
      ],
    );
  }

  AppBar appBarView(BuildContext context, McqProvider mcqProvider,
      List<QuestionModel> mcqData) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          context.read<McqProvider>().setSelectedMcqAnswer = '';
          mcqProvider.setCurrentQuestionIndex = 0;
          mcqProvider.checkResult = false;
          Navigator.pop(context);
        },
        child: const Icon(FontAwesomeIcons.angleLeft),
      ),
      elevation: 0,
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.black),
      title: CustomText(
        text: mcqData[mcqProvider.currentQuestionIndex].quizType ==
                AppStrings.notes
            ? AppStrings.notesCapital
            : mcqData[mcqProvider.currentQuestionIndex].quizType ==
                    AppStrings.match
                ? AppStrings.matchCapital
                : mcqData[mcqProvider.currentQuestionIndex].quizType ==
                        AppStrings.fillup
                    ? AppStrings.fillupCapital
                    : mcqData[mcqProvider.currentQuestionIndex].quizType ==
                            AppStrings.video
                        ? AppStrings.videoCapital
                        : AppStrings.mcqsCapital,
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(top: 20, right: 10),
          color: Colors.transparent,
          child: (context.watch<SubjectViewModel>().questions.isEmpty)
              ? null
              : CustomText(
                  text:
                      "${mcqProvider.currentQuestionIndex + 1}/${mcqData.length}",
                ),
        )
      ],
    );
  }

// for the menu options
  PopupMenuItem<McqMenu> buildItem(McqMenu item) =>
      PopupMenuItem<McqMenu>(value: item, child: Text(item.text));

  onSelected(
    BuildContext context,
    McqMenu item,
    List<QuestionModel> mcqData,
    McqProvider mcqProvider,
  ) {
    switch (item) {
      case McqMenuItems.startAgain:
        pageController.jumpTo(0);

        break;

      case McqMenuItems.searchQuestion:
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  setState(() {
                    questionController.text = "";
                  });
                },
                child: const CustomText(
                  text: AppStrings.cancel,
                ),
              ),
              TextButton(
                onPressed: () {
                  int questionNumber = int.parse(questionController.text);
                  int totalQuestions =
                      context.read<SubjectViewModel>().questions.length;
                  if (int.parse(questionController.text) < 0) {
                    setState(() {});
                    showSnackBar(
                        context: context,
                        message: AppStrings.enterPositiveNumber);
                  }
                  if (questionController.text == "") {
                    showSnackBar(
                        context: context,
                        message: AppStrings.enterPositiveNumber);
                  }
                  var mcqProviderData =
                      Provider.of<McqProvider>(context, listen: false);

                  if (questionNumber > totalQuestions) {
                    showSnackBar(
                      context: context,
                      message:
                          "Total Questions are $totalQuestions. Please enter valid number",
                    );
                  } else {
                    questionController.text = "";
                    mcqProviderData.setCurrentQuestionIndex =
                        questionNumber - 1;
                    pageController.jumpToPage(questionNumber - 1);
                    Navigator.of(context).pop();
                  }
                },
                child: const CustomText(
                  text: 'OK',
                ),
              ),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    CustomText(
                      text: AppStrings.enterTheQuestionNumber,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ],
                ),
                const Divider(),
                10.verticalSpace,
                // popup for serch question
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: questionController,
                  decoration: InputDecoration(
                    hintText: AppStrings.gotToQuestionNumber,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(5),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: AppColors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          barrierDismissible: false,
        );
        break;

      case McqMenuItems.report:
        // var authVm = Provider.of<AuthVm>(context, listen: false);
        // log("___________AUTH VM:${authVm.userModel?.firstName}");
        String? encodeQueryParameters(Map<String, String> params) {
          return params.entries
              .map((MapEntry<String, String> e) =>
                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
              .join('&');
        }

// mail for report
        final Uri emailLaunchUri = Uri(
          scheme: AppStrings.mailToText,
          path: AppStrings.reportEmail,
          query: Constant.prefs.getString(SharedPrefsHelper.firstName) ==
                      null ||
                  Constant.prefs
                          .getString(SharedPrefsHelper.lastName)
                          ?.isEmpty ==
                      true ||
                  Constant.prefs.getString(SharedPrefsHelper.lastName) == '' ||
                  Constant.prefs
                          .getString(SharedPrefsHelper.firstName)
                          ?.isEmpty ==
                      true
              ? encodeQueryParameters(<String, String>{
                  AppStrings.subjectText:
                      '${AppStrings.userIDText}: ${FirebaseAuth.instance.currentUser?.uid}\n  ${AppStrings.mobileNoText} - ${context.read<SubjectViewModel>().userModel.mobileNumber ?? 'Guest User'}',
                  AppStrings.bodyText:
                      '${AppStrings.reportText}  - ${context.read<SubjectViewModel>().selectedSubjectModel!.subjectName} - ${AppStrings.questionIDText}: ${mcqData[mcqProvider.currentQuestionIndex].uniqueId} \nVersion 2.2.0',
                })
              : encodeQueryParameters(<String, String>{
                  AppStrings.subjectText:
                      '${AppStrings.userIDText}: ${FirebaseAuth.instance.currentUser?.uid}\n  ${AppStrings.mobileNoText} - ',
                  AppStrings.bodyText:
                      '${AppStrings.reportText}  -  - ${AppStrings.questionIDText}:\n ${AppStrings.versionText} : ${AppStrings.appVersion}',
                }),
        );
        launchUrl(emailLaunchUri);
        break;
    }
  }
}
