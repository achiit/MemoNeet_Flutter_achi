import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/MVVM/views/TopicView/topic_card.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/repo/ad_mob_service.dart';
import 'package:memo_neet/utils/widgets/appbar/reusable_appbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:provider/provider.dart';

class TopicView extends StatefulWidget {
  static const String route = "/topic-view";
  const TopicView({super.key});

  @override
  State<TopicView> createState() {
    return _TopicViewState();
  }
}

class _TopicViewState extends State<TopicView> with TickerProviderStateMixin {
  DateTime? expiryDate;
  TextEditingController textController = TextEditingController();
  BannerAd? _banner;

  // void _createBannerAd() {
  //   _banner = BannerAd(
  //     size: AdSize.fullBanner,
  //     adUnitId: AdHelper.bannerAdUnitId,
  //     listener: AdHelper.bannerListener,
  //     request: const AdRequest(),
  //   )..load();
  // }
  AdHelper adHelper = AdHelper();
  @override
  void initState() {
    super.initState();
    _banner = adHelper.bannerAd;
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return mobileView(context);
    } else {
      return tabletView(context);
    }
  }

  Scaffold tabletView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ReusableAppbar.myAppBar(
        context: context,
        title:
            context.read<SubjectViewModel>().selectedChapterModel!.chapterName,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 7.5,
          crossAxisCount: 2, // Number of columns
          // mainAxisSpacing: 20.0, // Spacing between rows
        ),
        itemCount: context.read<SubjectViewModel>().topics.length,
        itemBuilder: (context, index) {
          return TopicCard(index: index);
        },
      ),
      bottomNavigationBar:
          _banner == null || context.read<UserViewModel>().isSubscribedUser
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  height: 52,
                  child: AdWidget(ad: _banner!),
                ),
    );
  }

  Scaffold mobileView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ReusableAppbar.myAppBar(
        context: context,
        title:
            context.read<SubjectViewModel>().selectedChapterModel!.chapterName,
      ),
      body: ListView.builder(
        itemCount: context.read<SubjectViewModel>().topics.length,
        itemBuilder: (context, index) {
          if (index == context.read<SubjectViewModel>().topics.length - 1) {
            return Column(
              children: [
                TopicCard(index: index),
                60.verticalSpace,
              ],
            );
          }

          return TopicCard(index: index);
        },
      ),
      bottomNavigationBar:
          _banner == null || context.read<UserViewModel>().isSubscribedUser
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  height: 52,
                  child: AdWidget(ad: _banner!),
                ),
    );
  }
}
