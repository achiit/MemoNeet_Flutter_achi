import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../MVVM/viewmodels/mcqs/mcq_provider.dart';
import '../../../repo/questions_services.dart';

class QuestionBar extends StatefulWidget {
  final String questionTitle;
  final QuestionModel question;
  const QuestionBar(
      {super.key, required this.questionTitle, required this.question});

  @override
  State<QuestionBar> createState() => _QuestionBarState();
}

class _QuestionBarState extends State<QuestionBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.only(left: 10),
          child: CustomText(
            text: widget.questionTitle,
            textAlign: TextAlign.start,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        20.horizontalSpace,
        FutureBuilder(
            future: context.read<McqProvider>().isQuestionBookmarked(
                context.read<SubjectViewModel>().selectedSubject,
                context
                    .read<SubjectViewModel>()
                    .selectedChapterModel!
                    .chapterName,
                widget.question),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              return Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      context.read<McqProvider>().isBookmarked =
                          !context.read<McqProvider>().isBookmarked;
                      context
                          .read<QuestionsServices>()
                          .toggleBookmark(
                              context.read<SubjectViewModel>().selectedSubject,
                              context
                                  .read<SubjectViewModel>()
                                  .selectedChapterModel!
                                  .chapterName,
                              widget.question)
                          .then((value) {
                        context.read<SubjectViewModel>().updateBookmarkTopics();
                      });
                      context.read<SubjectViewModel>().getSubjects();
                    },
                    child: Icon(
                      context.watch<McqProvider>().isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      color: AppColors.primaryColor,

                      // size: 30,
                    ),
                  ),
                ),
              );
            })
      ],
    );
  }
}
