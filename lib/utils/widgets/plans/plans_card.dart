import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/MVVM/models/plans/plan_model.dart';
import 'package:memo_neet/MVVM/viewmodels/Auth/auth_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/navigation/navigation_view_model.dart';
import 'package:memo_neet/MVVM/views/Auth/Login/View/login_screen.dart';
import 'package:memo_neet/MVVM/views/plans/buy_now.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/shared_prefs_helper.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

class PlansInnerCard extends StatelessWidget {
  final PlansModel data;
  const PlansInnerCard({super.key, required this.data});

  void navigateToBuyNow(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BuyNow(planData: data)));
  }

  void navigateToLogin(BuildContext context) async {
    Constant.prefs.setBool(SharedPrefsHelper.loggedIn, false);
    Constant.prefs.clear();
    FirebaseAuth.instance.signOut();
    Provider.of<NavigationViewModel>(context, listen: false).changePage(0);
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.route, (route) => false).then((value) {
      Provider.of<AuthViewModel>(context, listen: false).userModel = null;
    });
    showSnackBar(context: context, message: "Please Login to buy!");
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.verticalSpace,
        CustomText(
          text: data.subject,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        10.verticalSpace,
        Divider(
          color: AppColors.black,
        ),
        const CustomText(
          text: "include:",
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
        ),
        8.verticalSpace,
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                FontAwesomeIcons.check,
                color: AppColors.primaryColor,
                size: 20,
              ),
              10.horizontalSpace,
              const CustomText(
                text: "Biology",
                fontSize: 12.0,
              ),
              10.horizontalSpace,
              Icon(
                FontAwesomeIcons.check,
                color: AppColors.primaryColor,
                size: 20,
              ),
              10.horizontalSpace,
              const CustomText(
                text: "Physics",
                fontSize: 12.0,
              ),
              10.horizontalSpace,
              Icon(
                FontAwesomeIcons.check,
                color: AppColors.primaryColor,
                size: 20,
              ),
              10.horizontalSpace,
              const CustomText(
                fontSize: 12.0,
                text: "Chemistry",
              ),
            ],
          ),
        ),
        10.verticalSpace,
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                FontAwesomeIcons.xmark,
                color: AppColors.red,
                size: 20,
              ),
              10.horizontalSpace,
              const CustomText(
                text: "Test Series",
                fontSize: 12.0,
              ),
            ],
          ),
        ),
        userData.isSubscribedUser ? const SizedBox() : 16.verticalSpace,
        userData.isSubscribedUser
            ? const SizedBox()
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                  onPressed: () => Constant.prefs.getBool("isGuestUser") == true
                      ? navigateToLogin(context)
                      : navigateToBuyNow(context),
                  child: CustomText(
                    text: "Buy Now",
                    color: AppColors.white,
                    fontSize: 12.6587,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
        20.verticalSpace,
      ],
    );
  }
}
