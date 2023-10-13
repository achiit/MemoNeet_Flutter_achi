import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/practice_steps/practice_steps_header_section.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class PracticeSteps extends StatefulWidget {
  final VoidCallback onPressed;
  final String? subjectName;
  const PracticeSteps({this.subjectName, super.key, required this.onPressed});

  @override
  State<PracticeSteps> createState() => _PracticeStepsState();
}

class _PracticeStepsState extends State<PracticeSteps> {
  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return mobileView(context);
    } else {
      return tabletView(context);
    }
  }

  Scaffold tabletView(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              side: BorderSide(width: 1.0, color: AppColors.primaryColor),
              minimumSize: Size(MediaQuery.of(context).size.width / 3, 70),
            ),
            onPressed: widget.onPressed,
            child: CustomText(
              text: "Start",
              fontSize: 14.0,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(FontAwesomeIcons.angleLeft)),
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.black),
        title: const CustomText(
          text: "Practice",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PracticeStepsHeaderSection(
                subjectName: widget.subjectName!,
              ),
              // 50.verticalSpace,

              // 10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Scaffold mobileView(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: widget.onPressed,
          child: CustomText(
            text: "Start",
            color: AppColors.white,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(FontAwesomeIcons.angleLeft)),
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.black),
        title: const CustomText(
          text: "Practice",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PracticeStepsHeaderSection(
                subjectName: widget.subjectName!,
              ),
              // 50.verticalSpace,

              // 10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
