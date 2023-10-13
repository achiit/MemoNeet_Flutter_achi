import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/helpers/how_revision_works_helper.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class HowRevisionWorks extends StatelessWidget {
  const HowRevisionWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(FontAwesomeIcons.angleLeft)),
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.black),
        title: const CustomText(
          text: "Revision Algorithm Working",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          child: AnotherStepper(
            stepperList: stepperData,
            inActiveBarColor: AppColors.primaryColor,
            activeBarColor: AppColors.primaryColor,
            stepperDirection: Axis.vertical,
            iconWidth:
                45, // Height that will be applied to all the stepper icons
            iconHeight: 40,
            activeIndex:
                8, // Width that will be applied to all the stepper icons
          ),
        ),
      ),
    );
  }
}
