// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/utils/helpers/faqs_helper.dart';

import 'package:memo_neet/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

import 'package:url_launcher/url_launcher.dart';

class FaQsView extends StatelessWidget {
  static const String route = "/faqs-view";
  const FaQsView({super.key});

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
          text: "FAQ's",
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          CustomElevatedButton(
            elevation: 1,
            backgroundColor: AppColors.white,
            icon: Icons.call,
            iconSize: 30.0,
            iconColor: AppColors.black,
            buttonText: AppStrings.callTiming,
            onPressed: () async {
              final Uri url = Uri(
                scheme: AppStrings.tel,
                path: AppStrings.phoneNumber,
              );
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                showSnackBar(
                    context: context, message: AppStrings.cannotLaunch);
              }
            },
          ),
          10.verticalSpace,
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: faqsData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ExpansionTile(
                    title: CustomText(
                      text: faqsData[index].question,
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CustomText(
                          text: faqsData[index].details,
                          color: AppColors.darkGrey,
                        ),
                      )
                    ],
                  ),
                );
              })
        ],
      )),
    );
  }
}
