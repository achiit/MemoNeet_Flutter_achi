// ignore_for_file: implementation_imports, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/models/Auth/user_model.dart';
import 'package:memo_neet/MVVM/viewmodels/Auth/auth_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/navigation/navigation_view_model.dart';
import 'package:memo_neet/MVVM/views/Auth/Login/View/login_screen.dart';
import 'package:memo_neet/MVVM/views/settings/contact_support.dart';
import 'package:memo_neet/MVVM/views/settings/faqs_view.dart';
import 'package:memo_neet/MVVM/views/settings/my_profile.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/constants/urls.dart';
import 'package:memo_neet/utils/widgets/appbar/reusable_appbar.dart';
import 'package:memo_neet/utils/widgets/loader/loader.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/settings/settings_card.dart';
import 'package:memo_neet/utils/widgets/settings/settings_heading.dart';
import 'package:memo_neet/utils/widgets/settings/social_icon.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../viewmodels/User/user_view_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({
    super.key,
  });

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

UserModel? userData;

class _SettingsViewState extends State<SettingsView> {
  // void navigateToMyProfile(BuildContext context) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return UpdateProfile();
  //   })).then((value) {
  //     setState(() {});
  //   });
  // }

  // void navigateToMyContactSupport(BuildContext context) {
  //   Navigator.pushNamed(context, RoutesName.contactSupport);
  // }

  // void navigateToFAQsView(BuildContext context) {
  //   Navigator.pushNamed(context, RoutesName.faQs);
  // }

  // void navigateToRestoreAndBackup(BuildContext context) {
  //   Navigator.pushNamed(context, RoutesName.restoreAndBackup);
  // }

/*   Future<void> changeThemeDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          final themeChanger = Provider.of<ThemeChanger>(context);
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RadioListTile<ThemeMode>(
                    title: CustomText(text: "Light Mode"),
                    value: ThemeMode.light,
                    groupValue: themeChanger.themeMode,
                    onChanged: themeChanger.setTheme,
                  ),
                  RadioListTile<ThemeMode>(
                    title: CustomText(text: "Dark Mode"),
                    value: ThemeMode.dark,
                    groupValue: themeChanger.themeMode,
                    onChanged: themeChanger.setTheme,
                  ),
                  RadioListTile<ThemeMode>(
                    title: CustomText(text: "Default"),
                    value: ThemeMode.system,
                    groupValue: themeChanger.themeMode,
                    onChanged: themeChanger.setTheme,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  } */

  Future<void> changeLanguageDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(text: "Language"),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  RadioListTile(
                    activeColor: AppColors.primaryColor,
                    title: const Text("English"),
                    value: "English",
                    groupValue: "English",
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      appBar: ReusableAppbar.myAppBarWithoutLeadingIcon(
        context: context,
        title: "Settings",
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.bgCardBlue,
                                radius:
                                    MediaQuery.of(context).size.shortestSide <
                                            600
                                        ? 25
                                        : 35,
                                child: CustomText(
                                  text: authViewModel.isGuestUser == false
                                      ? context
                                              .read<UserViewModel>()
                                              .userModel
                                              ?.firstName![0] ??
                                          "G"
                                      : "G",
                                ),
                              ),
                              16.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: authViewModel.isGuestUser == false
                                        ? "${context.watch<UserViewModel>().userModel?.firstName} ${context.read<UserViewModel>().userModel?.lastName}"
                                        : "Guest User",
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .shortestSide <
                                            600
                                        ? 12.0
                                        : 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  CustomText(
                                    text: authViewModel.isGuestUser == false
                                        ? "Batch: ${context.watch<UserViewModel>().userModel?.batch}"
                                        : "Batch:",
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .shortestSide <
                                            600
                                        ? 10.0
                                        : 14.0,
                                    fontWeight: FontWeight.w400,
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      // Column(
                      //   children: [
                      //     SvgPicture.asset("assets/images/share_icon.svg"),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    5.verticalSpace,
                    // const SettingsHeading(text: "General"),
                    // 10.verticalSpace,

                    authViewModel.isGuestUser
                        ? const SizedBox()
                        : SettingsCard(
                            title: "My Profile",
                            image: AppImages.profileIcon,
                            onTap: () {
                              PageNavigator(ctx: context)
                                  .nextPage(page: const MyProfile());
                            },
                          ),
                    // 10.verticalSpace,
                    // SettingsCard(
                    //   title: "Bookmarks",
                    //   icon: Icons.bookmarks_outlined,
                    //   onTap: () {},
                    // ),
                    // 10.verticalSpace,

                    // SettingsCard(
                    //   title: "How to use",
                    //   // icon: Icons.info_outline,
                    //   image: "assets/images/how_to_use.svg",
                    //   onTap: () {},
                    // ),
                    // 10.verticalSpace,
                    // SettingsCard(
                    //   title: "Update Database",
                    //   icon: Icons.cloud_outlined,
                    //   onTap: () async {},
                    // ),
                    // 10.verticalSpace,
                    // const SettingsHeading(text: "Advanced"),
                    // 10.verticalSpace,
                    // SettingsCard(
                    //   title: "Restore & Backup",
                    //   image: AppImages.restore_and_backup_icon,
                    //   onTap: () {},
                    // ),
                    // 10.verticalSpace,
                    // SettingsCard(
                    //   title: "Refer & Earn",
                    //   image: AppImages.refer_and_earn,
                    //   onTap: () {},
                    // ),
                    // 10.verticalSpace,
                    // SettingsCard(
                    //   title: "Themes",
                    //   image: AppImages.themeIcon,
                    //   onTap: () {},
                    // ),
                    // 10.verticalSpace,
                    // SettingsCard(
                    //   title: "Language",
                    //   icon: Icons.language_outlined,
                    //   onTap: () => changeLanguageDialog(context),
                    // ),
                    10.verticalSpace,
                    const SettingsHeading(text: "Help"),
                    10.verticalSpace,

                    SettingsCard(
                      title: "FAQ's",
                      image: AppImages.faqsIcon,
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const FaQsView());
                      },
                    ),
                    10.verticalSpace,
                    SettingsCard(
                      title: "Contact Support",
                      image: AppImages.contact_support,
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const ContactSupport());
                      },
                    ),
                    10.verticalSpace,
                    SettingsCard(
                      title: "Logout",
                      image: AppImages.logoutIcon,
                      onTap: () async {
                        UIBlock.block(
                          context,
                          loadingTextWidget:
                              const CustomText(text: "Loging Out.."),
                          childBuilder: (context) => const Loader(),
                        );
                        context
                            .read<AuthViewModel>()
                            .logout(context)
                            .then((value) {
                          if (value == true) {
                            context.read<UserViewModel>().reset();

                            UIBlock.unblock(context);
                            Provider.of<NavigationViewModel>(context,
                                    listen: false)
                                .changePage(0);
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginScreen.route,
                                (route) => false).then((value) {
                              authViewModel.userModel = null;
                            });
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SettingsCard(
                      title: "Delete Account",
                      icon: Icons.delete,
                      onTap: () async {
                        UIBlock.block(
                          context,
                          loadingTextWidget:
                              const CustomText(text: "Loging Out.."),
                          childBuilder: (context) => const Loader(),
                        );
                        await context
                            .read<AuthViewModel>()
                            .logout(context)
                            .then((value) {
                          if (value == true) {
                            context.read<UserViewModel>().reset();

                            UIBlock.unblock(context);
                            Provider.of<NavigationViewModel>(context,
                                    listen: false)
                                .changePage(0);
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginScreen.route,
                                (route) => false).then((value) {
                              authViewModel.userModel = null;
                            });
                          }
                        });
                      },
                    ),
                    // 10.verticalSpace,
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    23.verticalSpace,
                    CustomText(
                      text: "Follow us on",
                      color: const Color(0xff1A112D),
                      fontSize: MediaQuery.of(context).size.shortestSide < 600
                          ? 14.0
                          : 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialIcon(
                          imageUrl: AppImages.telegram_logo,
                          url: AppUrls.telegramUrl,
                        ),
                        20.horizontalSpace,
                        SocialIcon(
                          imageUrl: AppImages.youtube_logo,
                          url: AppUrls.youtubeUrl,
                        ),
                        20.horizontalSpace,
                        SocialIcon(
                          imageUrl: AppImages.instagram_logo,
                          url: AppUrls.instaUrl,
                        ),
                      ],
                    ),
                    32.verticalSpace,
                    CustomText(
                      text: "Version ${AppStrings.appVersion}",
                      color: AppColors.darkGrey,
                      fontSize: MediaQuery.of(context).size.shortestSide < 600
                          ? 14.0
                          : 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              launchUrl(
                                  Uri.parse(Constant.termsAndConditionsUrl));
                            },
                            child: Text(
                              "Terms & Conditions",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize:
                                      MediaQuery.of(context).size.shortestSide <
                                              600
                                          ? 12.0
                                          : 16.0),
                            )),
                        Text(
                          " | ",
                          style:
                              TextStyle(color: AppColors.black, fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              launchUrl(Uri.parse(Constant.privicyPolicyUrl));
                            },
                            child: Text(
                              "privacy policy   ",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize:
                                      MediaQuery.of(context).size.shortestSide <
                                              600
                                          ? 12.0
                                          : 16.0),
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
