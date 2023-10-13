import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memo_neet/MVVM/views/Auth/Login/View/login_screen.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/constants/urls.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/onboarding/onboarding_helper_methods.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoardingScreen extends StatefulWidget {
  static const route = 'on-boarding-screen';
  const OnBoardingScreen({super.key});

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage(List<Widget> onboardingPages) {
    if (_currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      // Navigate to the next screen or complete onboarding
      // For simplicity, we'll just print a message for now
      PageNavigator(ctx: context).nextPage(page: const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> onboardingPages = [
      onBoardView(
        context: context,
        subjectPercentage: AppStrings.biologyPercentage,
        isShowProof: true,
        onProofPress: () {
          launchUrl(
            Uri.parse(
              AppUrls.showProofLink,
            ),
          );
        },
      ),
      onBoardView(
        context: context,
        subjectPercentage: AppStrings.chemistryPercentage,
        isShowProof: true,
        onProofPress: () {
          launchUrl(
            Uri.parse(
              AppUrls.showProofLink,
            ),
          );
        },
      ),
      onBoardView(
        context: context,
        subjectPercentage: AppStrings.physicsPercentage,
        isShowProof: false,
        onProofPress: () {},
      ),
      onBoardTestimonialView(context),
      onBoardTelegramView(
        subjectPercentage: AppStrings.physicsPercentage,
        isShowProof: false,
        onProofPress: () {},
        context: context,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                itemBuilder: (BuildContext context, int index) {
                  return onboardingPages[index];
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(onboardingPages),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: AppColors.bgCardBlue,
                    // ),
                    onPressed: () {
                      _nextPage(onboardingPages);
                    },
                    child: CustomText(
                      text: _currentPage < onboardingPages.length - 1
                          ? AppStrings.continueString
                          : AppStrings.finish,
                      fontSize: MediaQuery.of(context).size.shortestSide < 600
                          ? 12.0
                          : 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator(List<Widget> onboardingPages) {
    List<Widget> indicators = [];
    for (int i = 0; i < onboardingPages.length; i++) {
      indicators.add(
        i == _currentPage ? _indicator(true) : _indicator(false),
      );
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: 10,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,

        // borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  // final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    Key? key,
    // required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.onboard_new,
            height: 350,
          ),
          30.verticalSpace,
          CustomText(
            text: title,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          20.verticalSpace,
          CustomText(
            text: description,
            textAlign: TextAlign.center,
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
