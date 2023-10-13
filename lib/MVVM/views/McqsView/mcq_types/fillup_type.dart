import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:memo_neet/MVVM/viewmodels/mcqs/mcq_provider.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

import 'package:provider/provider.dart';

class FillUpType extends StatefulWidget {
  final List<QuestionModel> mcq;
  final int currentQuestionIndex;
  const FillUpType(
      {Key? key, required this.mcq, required this.currentQuestionIndex})
      : super(key: key);
  @override
  State<FillUpType> createState() => _FillUpTypeState();
}

class _FillUpTypeState extends State<FillUpType> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;
  List<String> options = [];
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    var qVm = Provider.of<McqProvider>(context, listen: false);
    options = widget.mcq[widget.currentQuestionIndex].optionA.split(",");
    options.shuffle();
    qVm.fillUpList.clear();
    // qVm.update();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    // });
  }

  void scaleAnimation() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(
      begin: 0,
      end: 50.0,
    ).animate(
      CurvedAnimation(
          parent: _controller!,
          curve: Curves.easeInToLinear,
          reverseCurve: Curves.easeInBack),
    );
    _controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<McqProvider>(builder: (context, qVm, _) {
      return Column(
        children: [
          qVm.fillUpList.isEmpty
              ? Card(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    margin: const EdgeInsets.only(bottom: 5, right: 5),
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: AppStrings.tapOnRightOption,
                        fontSize: 14.0,
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: const EdgeInsets.only(left: 3.0),
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          qVm.fillUpList.length,
                          (index) => AnimatedBuilder(
                            animation: _controller!,
                            builder: (BuildContext context, Widget? child) {
                              return SizedBox(
                                height: _animation?.value,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CustomText(
                                    text: qVm.fillUpList[index],
                                    fontSize: 16.0,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    if (qVm.fillUpList
                        .isNotEmpty) // Only show the button when not empty
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              qVm.fillUpList.clear();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.primaryColor.withOpacity(0.5),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.clear,
                              color: AppColors.white,
                              size: 10,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
          200.verticalSpace,
          Column(
            children: [
              Wrap(
                children: List.generate(
                  options.length,
                  (index) => (options[index]) == ""
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            qVm.fillUpList.add(options[index]);

                            scaleAnimation();
                            qVm.update();
                          },
                          child: qVm.fillUpList.contains(options[index])
                              ? const SizedBox()
                              : fillupOptionsWidget(
                                  options[index],
                                ),
                        ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget fillupOptionsWidget(String option) {
    return Container(
      width: 80.0,
      height: 50.0,
      margin: const EdgeInsets.only(
        left: 10.0,
        bottom: 10,
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              // spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          border: Border.all(width: 1.5, color: Colors.white),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 20,
      ),
      child: Align(
        alignment: Alignment.center,
        child: CustomText(
          text: option,
          fontSize: 14.0,
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
