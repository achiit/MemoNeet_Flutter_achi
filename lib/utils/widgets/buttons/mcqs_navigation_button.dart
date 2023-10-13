// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/buttons/my_elevated_button.dart';

class McqsNavigationButtons extends StatelessWidget {
  final int totalLength;
  final int currentQuestionIndex;
  final VoidCallback previousButton;
  final VoidCallback nextButton;
  final VoidCallback checkButtonPress;
  const McqsNavigationButtons({
    super.key,
    required this.currentQuestionIndex,
    required this.previousButton,
    required this.nextButton,
    required this.checkButtonPress,
    required this.totalLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              currentQuestionIndex == 0
                  ? Expanded(
                      child: Container(
                        child: const Text(""),
                      ),
                    )
                  : Expanded(
                      child: GestureDetector(
                        onTap: previousButton,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.shortestSide < 600
                                    ? 12
                                    : 22,
                            horizontal: 10,
                          ),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
              Expanded(
                flex: 4,
                child: MyElevatedButton(
                  buttonText: "Check Answer",
                  onPressed: checkButtonPress,
                  borderRadius: 5.0,
                ),
              ),
              currentQuestionIndex + 1 == totalLength
                  ? Expanded(
                      child: Container(
                        child: const Text(""),
                      ),
                    )
                  : Expanded(
                      child: GestureDetector(
                        onTap: nextButton,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.shortestSide < 600
                                    ? 12
                                    : 22,
                            horizontal: 10,
                          ),
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.arrow_forward_ios,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
