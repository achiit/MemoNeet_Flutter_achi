import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/models/plans/plan_model.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/plans/plans_card.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

class PlansCardView extends StatelessWidget {
  final List<PlansModel> dataList;
  final String filter;

  const PlansCardView({Key? key, required this.dataList, required this.filter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserViewModel>(context);

    List<PlansModel> filteredList;

    if (filter == "All Plans") {
      filteredList = dataList; // Show all plans
    } else {
      filteredList = dataList.where((plan) => plan.planType == filter).toList();
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(left: 13.38, right: 13.38, bottom: 10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: userData.isSubscribedUser
                      ? AppColors.primaryColor
                      : AppColors.bgCardBlue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: filteredList[index].planType,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: userData.isSubscribedUser
                            ? AppColors.white
                            : const Color(0xff37353A),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: PlansInnerCard(data: filteredList[index]),
              ),
            ],
          ),
        );
      },
    );
  }
}
