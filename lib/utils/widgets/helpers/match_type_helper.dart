import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/mcqs/mcq_provider.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

Widget matchTypeDropOptions(
  int index,
  McqProvider mcqProvider,
) {
  String userOptionA = mcqProvider.mcqOptions.isNotEmpty &&
          mcqProvider.dropList.isNotEmpty
      ? "${mcqProvider.mcqOptions[0]},${mcqProvider.dropList.isNotEmpty ? mcqProvider.dropList[0] : ''}"
      : '';
  String userOptionB =
      mcqProvider.mcqOptions.length > 1 && mcqProvider.dropList.length > 1
          ? "${mcqProvider.mcqOptions[1]},${mcqProvider.dropList[1]}"
          : '';
  String userOptionC =
      mcqProvider.mcqOptions.length > 2 && mcqProvider.dropList.length > 2
          ? "${mcqProvider.mcqOptions[2]},${mcqProvider.dropList[2]}"
          : '';
  String userOptionD =
      mcqProvider.mcqOptions.length > 3 && mcqProvider.dropList.length > 3
          ? "${mcqProvider.mcqOptions[3]},${mcqProvider.dropList[3]}"
          : '';
  return Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Row(
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(bottom: 5, left: 5),
          constraints: const BoxConstraints(minHeight: 50),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: CustomText(
                text: mcqProvider.mcqOptions[index],
                color: AppColors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )),
        4.horizontalSpace,
        Expanded(
          child: Stack(
            children: [
              DragTarget(
                onAccept: (item) {
                  if (mcqProvider.dropList[index].isEmpty) {
                    mcqProvider.dropList[index] = item.toString();
                    mcqProvider.dragOptions.remove(item.toString());
                    mcqProvider.update();
                  }
                },
                builder: (context, item, _) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: mcqProvider.checkResult
                              ? (userOptionA ==
                                          context
                                              .read<SubjectViewModel>()
                                              .questions[mcqProvider
                                                  .currentQuestionIndex]
                                              .optionA
                                              .toString() &&
                                      userOptionB ==
                                          context
                                              .read<SubjectViewModel>()
                                              .questions[mcqProvider
                                                  .currentQuestionIndex]
                                              .optionB
                                              .toString() &&
                                      userOptionC ==
                                          context
                                              .read<SubjectViewModel>()
                                              .questions[mcqProvider
                                                  .currentQuestionIndex]
                                              .optionC
                                              .toString() &&
                                      userOptionD ==
                                          context
                                              .read<SubjectViewModel>()
                                              .questions[mcqProvider
                                                  .currentQuestionIndex]
                                              .optionD
                                              .toString())
                                  ? Colors.green
                                  : Colors.red
                              : AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 5, right: 5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CustomText(
                            text: mcqProvider.dropList[index].toString().isEmpty
                                ? "Drag & Drop selected options here"
                                : mcqProvider.dropList[index].toString(),
                            fontSize: 12.0,
                            color:
                                mcqProvider.dropList[index].toString().isEmpty
                                    ? AppColors.darkGrey
                                    : AppColors.black,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (mcqProvider.dropList[index].toString().isNotEmpty)
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      mcqProvider.dragOptions.add(mcqProvider.dropList[index]);
                      mcqProvider.dropList[index] = '';
                      mcqProvider.update();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.primaryColor.withOpacity(0.5),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        Icons.close,
                        color: AppColors.white,
                        size: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget matchTypeOptionsWidget(
    int index, McqProvider mcqProvider, BuildContext context) {
  return Draggable(
    data: mcqProvider.dragOptions[index],
    feedback: Opacity(
      opacity: 0.7,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * .5,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.60),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Align(
            alignment: Alignment.center,
            child: CustomText(
              text: mcqProvider.dragOptions[index],
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    ),
    childWhenDragging: Card(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          // border: Border.all(width: 1.5.w, color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Align(
          alignment: Alignment.center,
          child: CustomText(
            text: mcqProvider.dragOptions[index],
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
    child: Card(
      child: Container(
        margin: const EdgeInsets.only(bottom: 2, left: 5),
        decoration: BoxDecoration(
          // color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Align(
          alignment: Alignment.center,
          child: CustomText(
            text: mcqProvider.dragOptions[index],
            color: AppColors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}
