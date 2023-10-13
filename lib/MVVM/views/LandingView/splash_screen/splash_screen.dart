// ignore_for_file: unused_field, avoid_print, use_build_context_synchronously

import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memo_neet/MVVM/viewmodels/Auth/auth_view_model.dart';
import 'package:memo_neet/MVVM/views/LandingView/onboarding/on_boarding_screen.dart';
import 'package:memo_neet/constants/shared_prefs_helper.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/repo/ad_mob_service.dart';
import 'package:memo_neet/utils/widgets/navigation_bar/custom_navigation_bar.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/subject/subject_view_model.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/splashViewRoute';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<dynamic>? _rotateAnimation;
  Animation<dynamic>? _scaleAnimation;
  BannerAd? _banner;
  AdHelper adHelper = AdHelper();

  @override
  void initState() {
    super.initState();
    _banner = adHelper.bannerAd;
    _banner = adHelper.bannerAd;
    // precacheImage(AssetImage("assets/images/biology.png"), context);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _rotateAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 2 * math.pi, end: math.pi)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 1),
      TweenSequenceItem<double>(
          tween: ConstantTween<double>(math.pi), weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: math.pi, end: 0.0)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 1)
    ]).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(
          0.3,
          1,
          curve: Curves.linear,
        ),
      ),
    );
    _animationController!.forward();
    navigateToNext();
  }

  // void _createBannerAd() {
  //   _banner = BannerAd(
  //     size: AdSize.fullBanner,
  //     adUnitId: AdHelper.bannerAdUnitId,
  //     listener: AdHelper.bannerListener,
  //     request: const AdRequest(),
  //   )..load();
  // }

  navigateToNext() {
    Future.delayed(const Duration(seconds: 4), () async {
      await checkCurrentUser();
      await checkQuestionLoaded(context);
    });
  }

  Future<void> checkCurrentUser() async {
    if (Constant.prefs.getBool(SharedPrefsHelper.loggedIn) == true) {
      log("user logged in");

      if (FirebaseAuth.instance.currentUser == null ||
          Constant.prefs.getBool(SharedPrefsHelper.isGuestUser) == true) {
        log("looged in as guest user");
        context.read<AuthViewModel>().isGuestUser = true;
      } else {
        context.read<AuthViewModel>().isGuestUser = false;
      }
      Navigator.pushNamedAndRemoveUntil(
          context, CustomNavigationBar.route, (Route<dynamic> route) => false);
    } else {
      PageNavigator(ctx: context).nextPage(page: const OnBoardingScreen());
    }
  }

  Future<void> checkQuestionLoaded(BuildContext context) async {
    // await Hive.openBox<SubjectModel>(Constant.subjectsBoxName);
    // await Hive.openBox<QuestionListModel>(Constant.questionsBoxName);
    if (Constant.prefs.getBool(SharedPrefsHelper.questionStored) != true ||
        Constant.prefs.getString(SharedPrefsHelper.appVersion) !=
            AppStrings.appVersion) {
      log("------------------ storing questions ------------------");
      context.read<SubjectViewModel>().isQuestionLoading = true;
      await context.read<SubjectViewModel>().loadQuestions().then((value) {
        Constant.prefs
            .setString(SharedPrefsHelper.appVersion, AppStrings.appVersion);
        showSnackBar(
            context: context, message: "Questions Loaded Successfully");
        // Navigator.pushNamedAndRemoveUntil(context, CustomNavigationBar.route, (Route<dynamic> route) => false);
      });
    } else {
      log("------------------ questions already stored ------------------");
      // Navigator.pushNamedAndRemoveUntil(context, CustomNavigationBar.route, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Image.asset(
            AppImages.splash_logo,
            scale: 3.5,
          ),
        ),
        bottomNavigationBar: _banner == null
            ? const SizedBox()
            : Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 52,
                child: AdWidget(ad: _banner!),
              ));
  }
}
