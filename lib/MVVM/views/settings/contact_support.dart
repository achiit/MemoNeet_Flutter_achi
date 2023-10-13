// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/constants/urls.dart';

import 'package:memo_neet/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

import 'package:url_launcher/url_launcher.dart';

class ContactSupport extends StatelessWidget {
  static const String route = "/contact-support";
  const ContactSupport({super.key});

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
          text: AppStrings.help,
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          20.verticalSpace,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomText(
              text: AppStrings.forInstantSupport,
              color: AppColors.darkGrey,
            ),
          ),
          30.verticalSpace,
          CustomElevatedButton(
            backgroundColor: AppColors.white,
            icon: Icons.call,
            iconSize: 30.0,
            iconColor: AppColors.primaryColor,
            imageSize: 4.0,
            buttonText: AppStrings.callTiming,
            textColor: Colors.blue,
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
          CustomElevatedButton(
            backgroundColor: AppColors.white,
            image: AppImages.telegram_logo,
            buttonText: AppStrings.joinTelegram,
            textColor: Colors.blue,
            imageSize: 4.0,
            onPressed: () async {
              await launchUrl(Uri.parse(AppUrls.telegramUrl));
            },
          ),
          10.verticalSpace,
          CustomElevatedButton(
            backgroundColor: AppColors.white,
            icon: Icons.email,
            iconSize: 30.0,
            iconColor: AppColors.primaryColor,
            buttonText: AppStrings.sendEmail,
            textColor: Colors.blue,
            imageSize: 4.0,
            onPressed: () async {
              launchUrl(Uri.parse(
                  'mailto:${AppStrings.supportEmail}?subject=UserID:Testing Version: testing'));
            },
          ),
        ],
      )),
    );
  }
}
