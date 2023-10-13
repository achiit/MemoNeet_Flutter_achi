import 'package:flutter/material.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

class ReusableAppbar {
  static AppBar myAppBar(
      {required BuildContext context, required String title}) {
    return AppBar(
      leading: InkWell(
          onTap: () {
            // if (context
            //     .read<SubjectViewModel>()
            //     .selectedTopicModel!
            //     .isBookmark) {
            //   context.read<SubjectViewModel>().updateBookmarkTopics();
            // }
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios)),
      elevation: 0,
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.black),
      title: CustomText(
        text: title,
      ),
    );
  }

  static AppBar myAppBarWithLeading(
      {required BuildContext context,
      required String title,
      required VoidCallback onLeadingPress}) {
    return AppBar(
      leading: InkWell(
          onTap: onLeadingPress, child: const Icon(Icons.arrow_back_ios)),
      elevation: 0,
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.black),
      title: CustomText(
        text: title,
      ),
    );
  }

  static AppBar myAppBarWithActionIcon({
    required BuildContext context,
    required String title,
    required List<Widget>? actions,
  }) {
    return AppBar(
      actions: actions,
      elevation: 0,
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.black),
      title: CustomText(
        text: title,
      ),
    );
  }

  static AppBar myAppBarWithoutLeadingIcon(
      {required BuildContext context, required String title}) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.black),
      title: CustomText(
        text: title,
      ),
    );
  }
}
