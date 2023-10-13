// data to be shown in the steps
import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

List<StepperData> stepperData = [
  StepperData(
    title: StepperText(
      "First you need to learn on the first screen of Biology/ Chemistry/Physics",
      textStyle: GoogleFonts.poppins(
        color: Colors.black,
      ),
    ),
    iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CustomText(
          text: "1",
          color: AppColors.white,
        ),
      ),
    ),
  ),
  StepperData(
    title: StepperText(
      "After 24 hours the questions you learned will come to the temporary memory part in the Revision section (All the question will come both right and wrong).",
      textStyle: GoogleFonts.poppins(
        color: Colors.black,
      ),
    ),
    iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CustomText(
          text: "2",
          color: AppColors.white,
        ),
      ),
    ),
  ),
  StepperData(
    title: StepperText(
      "To pass on question from temporary to short-term memory you need to answer them right then only it will go to the next level",
      textStyle: GoogleFonts.poppins(
        color: Colors.black,
      ),
    ),
    iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CustomText(
          text: "3",
          color: AppColors.white,
        ),
      ),
    ),
  ),
  StepperData(
    title: StepperText(
      "Like that there are seven-steps to move it to permanent long-term memory.",
      textStyle: GoogleFonts.poppins(
        color: Colors.black,
      ),
    ),
    iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CustomText(
          text: "4",
          color: AppColors.white,
        ),
      ),
    ),
  ),
  StepperData(
    title: StepperText(
      "But at any level if you did a wrong answer it will stay in that level for the next level. For example when moving from temporary to short term if you got one question wrong you need to get it right by next day.",
      textStyle: GoogleFonts.poppins(
        color: Colors.black,
      ),
    ),
    iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CustomText(
          text: "5",
          color: AppColors.white,
        ),
      ),
    ),
  ),
  StepperData(
    title: StepperText(
      "You must come to the practice section daily to move the questions from one level to the next. You will be notified too.",
      textStyle: GoogleFonts.poppins(
        color: Colors.black,
      ),
    ),
    iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CustomText(
          text: "6",
          color: AppColors.white,
        ),
      ),
    ),
  ),
  StepperData(
    title: StepperText(
      "There is also a time period. Like if you practice one question form temporary memory today and move it to the short term it won't appear today itself in the short term.",
      textStyle: GoogleFonts.poppins(
        color: Colors.black,
      ),
    ),
    iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CustomText(
          text: "7",
          color: AppColors.white,
        ),
      ),
    ),
  ),
  StepperData(
    title: StepperText(
      "It will take a minimum of 24 hours to appear. Like that in the Fibonacci series 1,3,5,7th day.",
      textStyle: GoogleFonts.poppins(
        color: Colors.black,
      ),
    ),
    iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CustomText(
          text: "8",
          color: AppColors.white,
        ),
      ),
    ),
  ),
  StepperData(
    title: StepperText(
      "All questions you practice from learning will go to temporary memory and them move towards long-term memory",
      textStyle: GoogleFonts.poppins(
        color: Colors.black,
      ),
    ),
    iconWidget: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CustomText(
          text: "9",
          color: AppColors.white,
        ),
      ),
    ),
  ),
];
