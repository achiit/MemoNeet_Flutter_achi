import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:memo_neet/MVVM/viewmodels/mcqs/mcq_provider.dart';
import 'package:memo_neet/utils/widgets/helpers/match_type_helper.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';

import 'package:provider/provider.dart';

class MatchTypeView extends StatefulWidget {
  final List<QuestionModel> mcq;
  final int currentQuestionIndex;
  const MatchTypeView(
      {Key? key, required this.mcq, required this.currentQuestionIndex})
      : super(key: key);
  @override
  State<MatchTypeView> createState() => _MatchTypeViewState();
}

class _MatchTypeViewState extends State<MatchTypeView> {
  @override
  void initState() {
    super.initState();

    var qVm = Provider.of<McqProvider>(context, listen: false);
    qVm.mcqOptions.clear();
    qVm.dragOptions.clear();

    String optionA = widget.mcq[qVm.currentQuestionIndex].optionA;
    if (optionA.isNotEmpty) {
      qVm.mcqOptions.add(optionA.split(",").first);
      qVm.dragOptions.add(optionA.split(",").last);
    }

    String optionB = widget.mcq[qVm.currentQuestionIndex].optionB;
    if (optionB.isNotEmpty) {
      qVm.mcqOptions.add(optionB.split(",").first);
      qVm.dragOptions.add(optionB.split(",").last);
    }

    String optionC = widget.mcq[qVm.currentQuestionIndex].optionC;
    if (optionC.isNotEmpty) {
      qVm.mcqOptions.add(optionC.split(",").first);
      qVm.dragOptions.add(optionC.split(",").last);
    }

    String optionD = widget.mcq[qVm.currentQuestionIndex].optionD;
    if (optionD.isNotEmpty) {
      qVm.mcqOptions.add(optionD.split(",").first);
      qVm.dragOptions.add(optionD.split(",").last);
    }

    qVm.dropList = List.generate(qVm.mcqOptions.length, (_) => "");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<McqProvider>(
      builder: (context, qVm, _) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          // Wrap the column with SingleChildScrollView
          child: Column(
            children: [
              // Use ListView.builder with shrinkWrap for the options
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: qVm.mcqOptions.length,
                itemBuilder: (context, index) => matchTypeDropOptions(
                  index,
                  qVm,
                ),
              ),
              10.verticalSpace,
              // Use ListView.builder with shrinkWrap for the drag options
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: qVm.dragOptions.length,
                itemBuilder: (context, index) => Container(
                  child: matchTypeOptionsWidget(index, qVm, context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
