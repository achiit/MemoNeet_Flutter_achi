// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/mcqs/mcq_provider.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

class McqOption extends StatefulWidget {
  final String leadingTitle;
  final String optionTitle;
  final bool isSelected;
  final VoidCallback onPressed;

  const McqOption({
    Key? key,
    required this.leadingTitle,
    required this.optionTitle,
    this.isSelected = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  McqOptionState createState() => McqOptionState();
}

class McqOptionState extends State<McqOption> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(McqOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      isSelected = widget.isSelected;
    }
  }

  void toggleOption() {
    setState(() {
      isSelected = !isSelected;
    });

    if (isSelected) {
      // The option was selected, so you can access the title using widget.optionTitle
    }
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<McqProvider>(builder: (context, qVm, _) {
      final mcqData = context.read<SubjectViewModel>().questions;
      final question = mcqData[qVm.currentQuestionIndex];
      bool isCorrectAnswer = question.answer == widget.optionTitle;

      return IgnorePointer(
        ignoring: qVm.checkResult,
        child: GestureDetector(
          onTap: toggleOption,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected || qVm.checkResult == true && isCorrectAnswer
                    ? (qVm.checkResult == true &&
                            question.answer == widget.optionTitle)
                        ? AppColors.lightGreen
                        : (qVm.checkResult == true &&
                                question.answer != widget.optionTitle)
                            ? AppColors.red
                            : AppColors.primaryColor
                    : AppColors.bgGrey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isSelected ||
                              qVm.checkResult == true && isCorrectAnswer
                          ? (qVm.checkResult == true &&
                                  question.answer == widget.optionTitle)
                              ? AppColors.lightGreen // Correct answer
                              : (qVm.checkResult == true &&
                                      question.answer != widget.optionTitle)
                                  ? AppColors.red // Wrong answer
                                  : AppColors.primaryColor
                          : AppColors.bgGrey,
                      shape: BoxShape.circle,
                    ),
                    child: CustomText(
                      text: widget.leadingTitle,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: isSelected ? AppColors.white : AppColors.black,
                    ),
                  ),
                ),
                20.horizontalSpace,
                Expanded(
                  child: Wrap(
                    children: [
                      CustomText(
                        text: widget.optionTitle,
                        textAlign: TextAlign.start,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
