import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> imagesData = [
  AppImages.comment1,
  AppImages.comment2,
  AppImages.comment3,
  AppImages.comment4,
  AppImages.comment5,
  AppImages.comment6,
  AppImages.comment7,
  AppImages.comment8,
  AppImages.comment9,
];

SingleChildScrollView onBoardView({
  required String subjectPercentage,
  required VoidCallback onProofPress,
  bool isShowProof = false,
  required BuildContext context,
}) {
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  if (shortestSide < 600) {
    return onBoardmobileView(subjectPercentage, isShowProof, onProofPress);
  } else {
    return onBoardtabletView(
        subjectPercentage, isShowProof, onProofPress, context);
  }
}

SingleChildScrollView onBoardmobileView(
    String subjectPercentage, bool isShowProof, VoidCallback onProofPress) {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            AppImages.onboard_new,
            height: 350,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text:
                    "MemoNeet: Your Shortcut to NEET 2024 Success - $subjectPercentage Coverage Guaranteed!",
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
              30.verticalSpace,
              CustomText(
                text:
                    "Crush NEET 2024 with MemoNeet - $subjectPercentage coverage proven. Get ultimate resources for exam success",
                color: AppColors.darkGrey,
              ),
              30.verticalSpace,
              isShowProof
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              width: 1.0, color: AppColors.primaryColor),
                          minimumSize: const Size(double.infinity, 50)),
                      onPressed: onProofPress,
                      child: CustomText(
                        text: "Show Proof",
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ],
      ),
    ),
  );
}

SingleChildScrollView onBoardtabletView(String subjectPercentage,
    bool isShowProof, VoidCallback onProofPress, BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            AppImages.onboard_new,
            height: MediaQuery.of(context).size.height / 2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  text:
                      "MemoNeet: Your Shortcut Longcut to NEET 2024 Success - $subjectPercentage Coverage Guaranteed!",
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              30.verticalSpace,
              Center(
                child: CustomText(
                  text:
                      "Crush NEET 2024 with MemoNeet - $subjectPercentage coverage proven. Get ultimate resources for exam success",
                  color: AppColors.darkGrey,
                  fontSize: 18.0,
                ),
              ),
              30.verticalSpace,
              isShowProof
                  ? Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              width: 1.0, color: AppColors.primaryColor),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width / 3, 70),
                        ),
                        onPressed: onProofPress,
                        child: CustomText(
                          text: "Show Proof",
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ],
      ),
    ),
  );
}

SingleChildScrollView onBoardTestimonialView(BuildContext context) {
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  if (shortestSide < 600) {
    return mobileView();
  } else {
    return tabletView();
  }
}

SingleChildScrollView tabletView() {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text:
                      "Crush NEET Biology & Chemistry with MEMONEET's winning duo: NCERT textbooks & ",
                  // style: DefaultTextStyle.of(context).style,
                  style: GoogleFonts.poppins(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '20k+',
                      style: GoogleFonts.poppins(
                        fontSize: 25.0,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                        text:
                            ' practice questions. Get complete coverage, start soaring now!',
                        style: GoogleFonts.poppins(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              30.verticalSpace,
              CustomText(
                text:
                    "• Crush NEET biology and chemistry with MEMONEET's powerful features.",
                color: AppColors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text:
                    "• Simplify your prep with 1500+ diagrams and chapter summaries framed as questions.",
                color: AppColors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text:
                    "• Tackle tough questions with 4000+ right/wrong and assertion-reasoning type questions.",
                color: AppColors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text:
                    "• Get the edge with previous year papers up to NEET 2021, organized by chapter with detailed solutions and explanations.",
                color: AppColors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text: "• Prepare like a pro and ace the exam with MEMONEET!",
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
              30.verticalSpace,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Read our glowing user reviews now!",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              20.verticalSpace,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: imagesData.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: index % 2 == 0 ? 10 : 30),
                    child: Image.asset(
                      imagesData[index],
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  );
                },
              ),
              20.verticalSpace,
            ],
          ),
        ],
      ),
    ),
  );
}

SingleChildScrollView mobileView() {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text:
                      "Crush NEET Biology & Chemistry with MEMONEET's winning duo: NCERT textbooks & ",
                  // style: DefaultTextStyle.of(context).style,
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '20k+',
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                        text:
                            ' practice questions. Get complete coverage, start soaring now!',
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              30.verticalSpace,
              CustomText(
                text:
                    "• Crush NEET biology and chemistry with MEMONEET's powerful features.",
                color: AppColors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text:
                    "• Simplify your prep with 1500+ diagrams and chapter summaries framed as questions.",
                color: AppColors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text:
                    "• Tackle tough questions with 4000+ right/wrong and assertion-reasoning type questions.",
                color: AppColors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text:
                    "• Get the edge with previous year papers up to NEET 2021, organized by chapter with detailed solutions and explanations.",
                color: AppColors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text: "• Prepare like a pro and ace the exam with MEMONEET!",
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
              30.verticalSpace,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Read our glowing user reviews now!",
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              20.verticalSpace,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: imagesData.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: index % 2 == 0 ? 10 : 30),
                    child: Image.asset(
                      imagesData[index],
                    ),
                  );
                },
              ),
              20.verticalSpace,
            ],
          ),
        ],
      ),
    ),
  );
}

SingleChildScrollView onBoardTelegramView({
  required String subjectPercentage,
  required VoidCallback onProofPress,
  bool isShowProof = false,
  required BuildContext context,
}) {
  var shortestSide = MediaQuery.of(context).size.shortestSide;

  if (shortestSide < 600) {
    return mobileViewForTelegramScreen();
  } else {
    return tabletViewforTelegramScreen(context);
  }
}

SingleChildScrollView tabletViewforTelegramScreen(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  AppImages.telegram3d,
                  height: 300,
                ),
              ),
              20.verticalSpace,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Join Our Telegram Channel",
                    fontWeight: FontWeight.w500,
                    fontSize: 25.0,
                  ),
                ],
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    textAlign: TextAlign.center,
                    text:
                        "Join the MemoNeet Community now and connect with 5000+ hardcore NEET aspirants and past toppers to discuss and clarify your doubts. Click the button below to join!",
                    color: AppColors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      side:
                          BorderSide(width: 1.0, color: AppColors.primaryColor),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 3, 70),
                    ),
                    onPressed: () async {
                      String url = "https://t.me/neettipstricks";
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /* SizedBox(
              width: 40,
            ), */
                        Icon(
                          Icons.telegram,
                          color: AppColors.white,
                        ),
                        5.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Join telegram Channel",
                              fontSize: 14.0,
                              color: AppColors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              30.verticalSpace,
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text:
                        "Congratulations on finishing all tasks! As a reward, enjoy two units of ",
                    // style: DefaultTextStyle.of(context).style,
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '2000+',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                          text:
                              ' practice questions for FREE. Keep learning with MEMONEET!',
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

SingleChildScrollView mobileViewForTelegramScreen() {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  AppImages.telegram3d,
                  height: 200,
                ),
              ),
              20.verticalSpace,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Join Our Telegram Channel",
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ],
              ),
              20.verticalSpace,
              CustomText(
                textAlign: TextAlign.center,
                text:
                    "Join the MemoNeet Community now and connect with 5000+ hardcore NEET aspirants and past toppers to discuss and clarify your doubts. Click the button below to join!",
                color: AppColors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
              ),
              30.verticalSpace,
              CustomElevatedButton(
                icon: Icons.telegram,
                iconColor: AppColors.white,
                backgroundColor: AppColors.primaryColor,
                buttonText: "Join Telegram Channel",
                textColor: AppColors.white,
                onPressed: () async {
                  String url = "https://t.me/neettipstricks";
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalApplication);
                  }
                },
              ),
              30.verticalSpace,
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text:
                        "Congratulations on finishing all tasks! As a reward, enjoy two units of ",
                    // style: DefaultTextStyle.of(context).style,
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '2000+',
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                          text:
                              ' practice questions for FREE. Keep learning with MEMONEET!',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
