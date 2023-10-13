// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/utils/widgets/navigation_bar/custom_navigation_bar.dart';
import 'package:provider/provider.dart';

class AdHelper {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;
  //if false ads will be shown
  bool isPremiumUser =
      false; // Add the boolean variable to determine premium status
  bool get ispremiumUser => isPremiumUser;

  //AdHelper(this.isPremiumUser);
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return AppStrings.banner;
    } else if (Platform.isIOS) {
      return AppStrings.banner;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  BannerAd? get bannerAd {
    if (!isPremiumUser) {
      createBannerAd(); // Create the banner ad if the user is not premium
    }
    return _bannerAd;
  }

  BannerAd createBannerAd() {
    // If the user is not a premium user, show the banner ad
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: AdHelper.bannerListener,
      request: const AdRequest(),
    )..load();

    log("done");

    return _bannerAd!;
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return AppStrings.interstitial;
    } else if (Platform.isIOS) {
      return AppStrings.interstitial;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/5224354917';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/2934735716';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }

//ad create
  void createInterstitialAd(BuildContext context) {
    if (context.read<UserViewModel>().isSubscribedUser == false) {
      InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _showInterstitialAd(context);
          },
          onAdFailedToLoad: (LoadAdError error) {
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd(context);
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomNavigationBar(),
                ),
                (route) => false,
              );
            }
          },
        ),
      );
    } else if (context
            .read<UserViewModel>()
            .isSubscribedUser
            .isSubscribedUser ==
        true) {
      // If the user is a premium user, skip loading the interstitial ad and directly navigate to the next screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const CustomNavigationBar(),
        ),
        (route) => false,
      );
    }
  }

  void _showInterstitialAd(BuildContext context) {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const CustomNavigationBar()),
          (route) => false,
        );
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint("Ad loaded"),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint("Ad failed to load: $error");
    },
    onAdOpened: (ad) => debugPrint("Ad opened"),
    onAdClosed: (ad) => debugPrint("Ad closed"),
  );
}
