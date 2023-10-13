// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/mcqs/diagram/image_previewer.dart';
import 'package:provider/provider.dart';

class DiagramWidget extends StatefulWidget {
  final String question;

  const DiagramWidget({super.key, required this.question});

  @override
  _DiagramWidgetState createState() => _DiagramWidgetState();
}

class _DiagramWidgetState extends State<DiagramWidget> {
  @override
  void initState() {
    super.initState();
    _loadDiagramData(widget.question);
  }

  Future<void> _loadDiagramData(String question) async {
    final subjectViewModel =
        Provider.of<SubjectViewModel>(context, listen: false);
    String subjectName =
        context.read<SubjectViewModel>().selectedSubjectModel!.subjectName;
    String key;
    if (subjectName == "Biology") {
      key = "biology_temporary";
    } else if (subjectName == "Chemistry") {
      key = "chemistry_images";
    } else {
      key = "physics_images";
    }
    subjectViewModel.getDiagram(key, question.split("(").last.split(")").first);
  }

  @override
  Widget build(BuildContext context) {
    final subjectViewModel =
        Provider.of<SubjectViewModel>(context, listen: false);
    if (subjectViewModel.diagramImageUrl == "" ||
        subjectViewModel.diagramImageUrl.isEmpty) {
      return SpinKitPulse(
        color: AppColors.primaryColor,
      );
    } else {
      return GestureDetector(
        onTap: () {
          ImagePreviewer(subjectViewModel.diagramImageUrl);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            height: 180,
            child: Image.network(subjectViewModel.diagramImageUrl),
          ),
        ),
      );
    }
  }
}
