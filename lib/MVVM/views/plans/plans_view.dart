// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:memo_neet/MVVM/models/plans/plan_model.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/utils/in_app_purchases/in_app_purchase.dart';
import 'package:memo_neet/utils/widgets/appbar/reusable_appbar.dart';
import 'package:memo_neet/utils/widgets/loader/loader.dart';
import 'package:memo_neet/utils/widgets/plans/plans_card_view.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

class PlansView extends StatefulWidget {
  const PlansView({Key? key}) : super(key: key);

  @override
  State<PlansView> createState() => _PlansViewState();
}

class _PlansViewState extends State<PlansView> {
  final ref = FirebaseDatabase.instance.ref();

  // var snapshot;
  String selectedFilter = "All Plans"; // Set initial value to "All Plans"

  Future<List<PlansModel>> buildPlans() async {
    List<PlansModel> plansData = [];

    context.read<InAppPurchaseManager>().products.forEach((element) {
      plansData.add(PlansModel(
          planType: context.read<UserViewModel>().isSubscribedUser
              ? "Already Subscribed"
              : "Recomended for you",
          subject: element.title,
          price: element.rawPrice,
          displayPrice: element.price));
    });
    return plansData;
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ReusableAppbar.myAppBarWithActionIcon(
        actions: [
          GestureDetector(
            onTap: () {
              _showFilterDialog();
            },
            child: Container(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(AppImages.filter_icon),
            ),
          ),
        ],
        context: context,
        title: "Plans",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              10.verticalSpace,
              FutureBuilder<List<PlansModel>>(
                future: buildPlans(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Loader());
                  }
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.hasData) {
                    return PlansCardView(
                        dataList: snapshot.data ?? [], filter: selectedFilter);
                  } else {
                    return CustomText(
                      text: "Server error: ${snapshot.error}",
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    );
                  }
                },
              ),
              10.verticalSpace
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Builder(
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Filter Plans"),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                content: SizedBox(
                  // height: dialogHeight,
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        activeColor: AppColors.primaryColor,
                        title: const Text("All Plans"), // Added "All" option
                        value: "All Plans",
                        groupValue: selectedFilter,
                        onChanged: (String? value) {
                          setState(() {
                            selectedFilter = value!;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: AppColors.primaryColor,
                        title: const Text("Recommended For You"),
                        value: "Recommended For You",
                        groupValue: selectedFilter,
                        onChanged: (String? value) {
                          setState(() {
                            selectedFilter = value!;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: AppColors.primaryColor,
                        title: const Text("Combo Offer"),
                        value: "Combo Offer",
                        groupValue: selectedFilter,
                        onChanged: (String? value) {
                          setState(() {
                            selectedFilter = value!;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
