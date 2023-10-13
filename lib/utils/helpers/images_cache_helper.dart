import 'package:flutter_svg/flutter_svg.dart';
import 'package:memo_neet/constants/images.dart';

Future<void> cacheImageList() async {
  List<String> imagesData = [
    AppImages.bio,
    AppImages.chem,
    AppImages.physics,
    AppImages.cart_icon_filled,
    AppImages.cart_icon,
    AppImages.congrats_mcq,
    AppImages.contact_support,
    AppImages.cross_mcq,
    AppImages.doctor,
    AppImages.google,
    AppImages.home_icon_filled,
    AppImages.home_icon,
    AppImages.learn_and_comeback,
    AppImages.plan1,
    AppImages.plan2,
    AppImages.plan3,
    AppImages.plan4,
    AppImages.practice1,
    AppImages.practice2,
    AppImages.practice3,
    AppImages.practice4,
    AppImages.settings_icon,
    AppImages.settings_icon_filled,
    AppImages.test_series_icon,
    AppImages.test_series_icon_filled,
    AppImages.themes_icon,
    AppImages.faqsIcon,
    AppImages.onboard_new,
    AppImages.themeIcon,
    AppImages.profileIcon,
    AppImages.logoutIcon,
    AppImages.congrats_mcq
  ];

  for (int i = 0; i < imagesData.length; i++) {
    await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, imagesData[i]),
      null,
    );
  }
}
