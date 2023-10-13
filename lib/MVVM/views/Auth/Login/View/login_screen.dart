import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/MVVM/viewmodels/Auth/auth_view_model.dart';
import 'package:memo_neet/MVVM/views/Auth/Login/phone_verification/phone_verification.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/repo/auth_services.dart';
import 'package:memo_neet/utils/widgets/buttons/custom_button.dart';
import 'package:memo_neet/utils/widgets/login/top_cover.dart';
import 'package:memo_neet/utils/widgets/navigation_bar/custom_navigation_bar.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const route = "/loginScreenViewRoute";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final otplessFlutterPlugin = Otpless();

  @override
  Widget build(BuildContext context) {
    var authVm = Provider.of<AuthViewModel>(context, listen: false);
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return mobileView(authVm, context);
    } else {
      return tabletView(authVm, context);
    }
  }

  Scaffold tabletView(AuthViewModel authVm, BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: TopCover(
                  imageHeight: MediaQuery.of(context).size.height / 2,
                ),
              ),
              // h30,

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        icon: Icon(
                          FontAwesomeIcons.person,
                          color: AppColors.primaryColor,
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 0.5, color: AppColors.black),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width / 3, 70),
                        ),
                        onPressed:
                            () {} /* () {
                          authVm.signInAsGuest(context);
                        } */
                        ,
                        label: CustomText(
                          text: "Continue as Guest",
                          fontSize: 14.0,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        icon: Icon(
                          FontAwesomeIcons.phone,
                          color: AppColors.primaryColor,
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 0.5, color: AppColors.black),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width / 3, 70),
                        ),
                        onPressed: () {
                          PageNavigator(ctx: context)
                              .nextPage(page: const PhoneVerification());
                        },
                        label: CustomText(
                          text: "Continue with Phone Number",
                          fontSize: 14.0,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),

                  10.verticalSpace,
                  // for ios
                  Platform.isIOS
                      ? CustomButton(
                          buttonText: "Continue with Apple",
                          iconColor: Colors.black,
                          icon: Icons.apple,
                          onPressed: () {
                            AuthService(FirebaseAuth.instance)
                                .signInWithApple(context);
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold mobileView(AuthViewModel authVm, BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: const TopCover(),
              ),
              // h30,

              Column(
                children: [
                  CustomButton(
                    buttonText: "Continue with WhatsApp",
                    icon: FontAwesomeIcons.whatsapp,
                    iconColor: AppColors.primaryColor,
                    onPressed: /* () {
                      authVm.signInAsGuest(context);
                    } */
                        () async {
                      var extra = {
                        "method": "get",
                        "param": {"cid": "9H0HP1UBOAKB6XAL45OOP5OOCV90NPJX"},
                      };

                      await otplessFlutterPlugin.start((result) {
                        var message = "";
                        if (result['data'] != null) {
                          final token = result['data']['token'];
                          message = "token: $token";
                          // Successful sign-in, navigate to CustomNavigationBar
                          Navigator.pushReplacementNamed(
                              context, CustomNavigationBar.route);
                        } else {
                          message = result['errorMessage'];
                          // Handle the case where sign-in was not successful
                        }
                      }, jsonObject: extra);
                    },
                  ),
                  10.verticalSpace,
                  CustomButton(
                      buttonText: "Continue as Guest",
                      icon: FontAwesomeIcons.person,
                      iconColor: AppColors.primaryColor,
                      onPressed: () {
                        authVm.signInAsGuest(context);
                      }),
                  // 10.verticalSpace,
                  // // for android
                  // CustomButton(
                  //   buttonText: "Continue with Google",
                  //   image: AppImages.googleIcon,
                  //   onPressed: () async {
                  //     authVm.signInWithGoogle(context);
                  //   },
                  // ),
                  10.verticalSpace,
                  CustomButton(
                    buttonText: "Continue with Phone Number",
                    icon: Icons.phone,
                    iconColor: AppColors.primaryColor,
                    onPressed: () {
                      PageNavigator(ctx: context)
                          .nextPage(page: const PhoneVerification());
                    },
                  ),
                  10.verticalSpace,
                  // for ios
                  Platform.isIOS
                      ? CustomButton(
                          buttonText: "Continue with Apple",
                          iconColor: Colors.black,
                          icon: Icons.apple,
                          onPressed: () {
                            AuthService(FirebaseAuth.instance)
                                .signInWithApple(context);
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
