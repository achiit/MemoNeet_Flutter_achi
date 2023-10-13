import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/utils/widgets/home_page/subjects_card.dart';
import 'package:provider/provider.dart';

class SubjectsView extends StatelessWidget {
  const SubjectsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: context.watch<SubjectViewModel>().subjects.length,
      itemBuilder: (context, index) {
        return SubjectsCard(
          index: index,
        );
      },
    );
  }
}
