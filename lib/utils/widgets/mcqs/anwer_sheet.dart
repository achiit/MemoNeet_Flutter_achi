import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/MVVM/views/McqsView/mcq_types/play_youtube_video.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/repo/ad_mob_service.dart';
import 'package:memo_neet/utils/widgets/loader/show_loader.dart';
import 'package:memo_neet/utils/widgets/mcqs/diagram/diagram_widget.dart';
import 'package:memo_neet/utils/widgets/navigation_bar/custom_navigation_bar.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';
import '../../../MVVM/viewmodels/mcqs/mcq_provider.dart';

AdHelper admobHelper = AdHelper();
void showBottomSheetWithAnswer(
    BuildContext context,
    PageController pageController,
    McqProvider mcqProvider,
    List<QuestionModel> mcqData) {
  showModalBottomSheet<void>(
    enableDrag: true,
    backgroundColor: AppColors.white,
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12))),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  12.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                          (context.read<McqProvider>().isAnswerCorrect)
                              ? AppImages.congrats_mcq
                              : AppImages.cross_mcq),
                      8.horizontalSpace,
                      Text(
                        (context.read<McqProvider>().isAnswerCorrect)
                            ? "Congratulations! You are right"
                            : "Opps! you are wrong.",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  18.verticalSpace,
                  mcqData[mcqProvider.currentQuestionIndex]
                          .question
                          .toString()
                          .contains("diagram")
                      ? Center(
                          child: DiagramWidget(
                            question: mcqData[mcqProvider.currentQuestionIndex]
                                .question,
                          ),
                        )
                      : const SizedBox(),
                  10.verticalSpace,
                  Text(
                    "Correct Option: ${context.read<McqProvider>().correctOption}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  24.verticalSpace,
                  const Text(
                    "Explanation :",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  6.verticalSpace,
                  Text(
                    context.read<McqProvider>().questionModel?.explanation ??
                        "",
                    style: const TextStyle(fontSize: 14),
                  ),
                  32.verticalSpace,
                  Container(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        var qVm =
                            Provider.of<McqProvider>(context, listen: false);

                        qVm.checkResult = false;
                        qVm.update();
                        if (mcqProvider.currentQuestionIndex ==
                            context.read<SubjectViewModel>().questions.length -
                                1) {
                          showLoader(context);
                          if (context.read<UserViewModel>().isSubscribedUser ==
                              true) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CustomNavigationBar(),
                              ),
                              (route) => false,
                            );
                          } else {
                            admobHelper.createInterstitialAd(context);
                          }

                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const CustomNavigationBar();
                          // }));
                          context.read<McqProvider>().setSelectedMcqAnswer = "";
                          showSnackBar(
                              context: context,
                              message: "Topic Completed Successfully!");
                        } else {
                          Navigator.pop(context);
                          mcqProvider.increaseIndex();
                          pageController
                              .jumpToPage(mcqProvider.currentQuestionIndex);
                        }
                      },
                      child: CustomText(
                        text: "Next",
                        color: AppColors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}

void showBottomSheetForMatchAndFillupType(
  BuildContext context,
  List<QuestionModel> mcq,
  PageController pageController,
  int currentQuestionIndex,
  McqProvider mcqProvider,
  bool isCorrect,
  bool isRevision,
) {
  showModalBottomSheet<void>(
    enableDrag: true,
    backgroundColor: AppColors.white,
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12))),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            child: Container(
              decoration: BoxDecoration(color: AppColors.white),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset(
                          isCorrect == true
                              ? AppImages.congrats_mcq
                              : AppImages.cross_mcq,
                          // height: 40,
                        ),
                      ),
                      CustomText(
                        text: isCorrect == true
                            ? "Congratulations! You are right!"
                            : "Oops! Better Luck Next Time",
                        textAlign: TextAlign.center,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  mcq[mcqProvider.currentQuestionIndex]
                          .question
                          .toString()
                          .contains("video")
                      ? PlayVideoFromYoutube(
                          videoId:
                              mcq[mcqProvider.currentQuestionIndex].question,
                        )
                      : const SizedBox(),
                  mcq[mcqProvider.currentQuestionIndex]
                          .question
                          .toString()
                          .contains("diagram")
                      ? Center(
                          child: DiagramWidget(
                            question:
                                mcq[mcqProvider.currentQuestionIndex].question,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text: "Correct Answer :",
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: mcq[mcqProvider.currentQuestionIndex]
                                  .answer
                                  .split(',')
                                  .length,
                              itemBuilder: (context, index) {
                                return CustomText(
                                  text:
                                      " ${mcq[mcqProvider.currentQuestionIndex].answer.split(',')[index]}",
                                  textAlign: TextAlign.left,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  CustomText(
                    text: "Explanation:",
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  10.verticalSpace,
                  10.verticalSpace,
                  CustomText(
                    text: mcq[mcqProvider.currentQuestionIndex].explanation,
                    fontSize: 14.0,
                  ),
                  10.verticalSpace,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () async {
                      if (mcqProvider.currentQuestionIndex ==
                          context.read<SubjectViewModel>().questions.length -
                              1) {
                        showSnackBar(
                            context: context,
                            message: "Topic Completed Successfully!");
                        if (context.read<UserViewModel>().isSubscribedUser ==
                            true) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CustomNavigationBar(),
                            ),
                            (route) => false,
                          );
                        } else {
                          admobHelper.createInterstitialAd(context);
                        }
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return const CustomNavigationBar();
                        // }));
                      } else {
                        Navigator.pop(context);
                        mcqProvider.increaseIndex();
                        pageController
                            .jumpToPage(mcqProvider.currentQuestionIndex);
                      }
                    },
                    child: const CustomText(
                      text: 'Next',
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
