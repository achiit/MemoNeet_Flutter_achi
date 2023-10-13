// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class RevisionTile extends StatelessWidget {
  final Color? backgroundColor;
  final String total_questions;
  final String imagePath;
  final void Function()? ontap;
  final void Function()? onLongPress;
  final String text;
  const RevisionTile({
    Key? key,
    this.backgroundColor,
    required this.ontap,
    required this.total_questions,
    required this.imagePath,
    required this.text,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return GestureDetector(
        onTap: ontap,
        onLongPress: onLongPress,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF787878).withOpacity(0.1),
                  offset: const Offset(1, 2),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor:
                          backgroundColor ?? AppColors.primaryColor,
                      child: Image.asset(imagePath,
                          color: AppColors.white, height: 40),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    // width: double.infinity,
                    child: CustomText(
                      text: text,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "No of Questions:",
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey,
                      ),
                      CustomText(
                        text: total_questions,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: ontap,
        onLongPress: onLongPress,
        child: Container(
          // margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF787878).withOpacity(0.1),
                  offset: const Offset(1, 2),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(14)),
          // padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 5, top: 15),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor:
                          backgroundColor ?? AppColors.primaryColor,
                      child: Image.asset(imagePath,
                          color: AppColors.white, height: 40),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    // width: double.infinity,
                    child: CustomText(
                      text: text,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "No of Questions:",
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey,
                      ),
                      CustomText(
                        text: total_questions,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

class CompletedQuestionTile extends StatelessWidget {
  final Color? backgroundColor;
  final String total_questions;
  final String text;
  const CompletedQuestionTile({
    Key? key,
    this.backgroundColor,
    required this.total_questions,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: const Color(0xFF598225).withOpacity(0.08),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF787878).withOpacity(0.1),
              offset: const Offset(1, 2),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFF598225),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // width: double.infinity,
                child: CustomText(
                  text: text,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.headingColor,
                ),
              ),
              Row(
                children: [
                  CustomText(
                    text: "Total: ",
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkGrey,
                  ),
                  CustomText(
                    text: total_questions,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.headingColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
