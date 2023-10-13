// ignore_for_file: use_build_context_synchronously, unused_field

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:memo_neet/MVVM/viewmodels/Auth/auth_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/navigation/navigation_view_model.dart';
import 'package:memo_neet/MVVM/views/HomeView/home_view.dart';
import 'package:memo_neet/MVVM/views/ProfileDetailPage/profile_detail_view.dart';
import 'package:memo_neet/MVVM/views/plans/plans_view.dart';
import 'package:memo_neet/MVVM/views/settings/settings_view.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/repo/ad_mob_service.dart';
import 'package:memo_neet/utils/in_app_purchases/in_app_purchase.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../MVVM/viewmodels/User/user_view_model.dart';

class CustomNavigationBar extends StatefulWidget {
  static const route = "/navigation-bar";
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  BannerAd? _banner;
  final tabs = [
    const Center(
      child: HomeView(),
    ),
    const Center(
      child: PlansView(),
    ),
    const Center(
      child: SettingsView(),
    ),
    // const Center(
    //   child: MockTest(),
    // ),
  ];

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (!context.read<AuthViewModel>().isGuestUser &&
          FirebaseAuth.instance.currentUser != null) {
        context.read<UserViewModel>().getUserInfo(context).then((value) {
          if (context.read<AuthViewModel>().userModelNull) {
            Navigator.pushReplacementNamed(context, ProfileDetialView.route);
          }
        });
      }
    });
    // }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<InAppPurchaseManager>().initialize(context);
    });
    getConnectivity();
    _createBannerAd();
  }

  void _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: AdHelper.bannerListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationBarIndex = Provider.of<NavigationViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: tabs[navigationBarIndex.page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        onTap: (index) {
          navigationBarIndex.changePage(index);
        },
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 13.0,
        selectedFontSize: 13.0,
        unselectedLabelStyle: TextStyle(
            color: AppColors.black,
            fontSize:
                MediaQuery.of(context).size.shortestSide < 600 ? 10.0 : 14.0),
        selectedLabelStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize:
                MediaQuery.of(context).size.shortestSide < 600 ? 10.0 : 14.0),
        currentIndex: navigationBarIndex.page,
        items: [
          BottomNavigationBarItem(
            icon: MediaQuery.of(context).size.shortestSide < 600
                ? SvgPicture.asset(
                    navigationBarIndex.page == 0
                        ? AppImages.home_icon_filled
                        : AppImages.home_icon,
                    color: navigationBarIndex.page == 0
                        ? AppColors.primaryColor
                        : Colors.black,
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      navigationBarIndex.page == 0
                          ? AppImages.home_icon_filled
                          : AppImages.home_icon,
                      color: navigationBarIndex.page == 0
                          ? AppColors.primaryColor
                          : Colors.black,
                    ),
                  ),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: MediaQuery.of(context).size.shortestSide < 600
                ? SvgPicture.asset(
                    navigationBarIndex.page == 1
                        ? AppImages.cart_icon_filled
                        : AppImages.cart_icon,
                    color: navigationBarIndex.page == 1
                        ? AppColors.primaryColor
                        : Colors.black,
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      navigationBarIndex.page == 1
                          ? AppImages.cart_icon_filled
                          : AppImages.cart_icon,
                      color: navigationBarIndex.page == 1
                          ? AppColors.primaryColor
                          : Colors.black,
                    ),
                  ),
            label: AppStrings.plans,
          ),
          BottomNavigationBarItem(
            icon: MediaQuery.of(context).size.shortestSide < 600
                ? SvgPicture.asset(
                    navigationBarIndex.page == 2
                        ? AppImages.settings_icon_filled
                        : AppImages.settings_icon,
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      navigationBarIndex.page == 2
                          ? AppImages.settings_icon_filled
                          : AppImages.settings_icon,
                    ),
                  ),
            label: AppStrings.settings,
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const CustomText(text: AppStrings.noConnection),
          content: const CustomText(text: AppStrings.checkConnectivity),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, AppStrings.cancel);
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const CustomText(text: AppStrings.ok),
            ),
          ],
        ),
      );
}
