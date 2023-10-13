import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memo_neet/MVVM/viewmodels/subject/subject_view_model.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/chapter_card.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/npcm_topics_view.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/revision/revision_screen.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/repo/ad_mob_service.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/User/user_view_model.dart';

class ChaptersView extends StatefulWidget {
  static const String route = "/chapters-screen";

  const ChaptersView({Key? key}) : super(key: key);

  @override
  State<ChaptersView> createState() => _ChaptersViewState();
}

class _ChaptersViewState extends State<ChaptersView>
    with TickerProviderStateMixin {
  late TabController _tabController;
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
    _banner = adHelper.bannerAd!..load();
    _tabController = TabController(
        length: (context.read<SubjectViewModel>().selectedSubject ==
                Subject.biology)
            ? 3
            : 2,
        vsync: this);
    _tabController.animateTo(0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
// mobile view
      return mobileView(context);
    } else {
      // tablet view
      return tabletView(context);
    }
  }

  Scaffold tabletView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: CustomText(
            text: context
                    .read<SubjectViewModel>()
                    .selectedSubjectModel
                    ?.subjectName ??
                ""),
        backgroundColor: AppColors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: IconThemeData(color: AppColors.black),
        bottom: TabBar(
          labelPadding: const EdgeInsets.all(8),
          indicatorColor: AppColors.primaryColor,
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          tabs: [
            const CustomText(
              text: AppStrings.practice,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: AppStrings.revision,
                ),
                7.horizontalSpace,
                // (context.watch<RevisionViewModel>().pendingQuestionCount != 0)
                //     ? Container(
                //         width: 10,
                //         height: 10,
                //         decoration: BoxDecoration(
                //             color: AppColors.primaryColor,
                //             shape: BoxShape.circle),
                //       )
                //     : const SizedBox()
              ],
            ),
            if (context.read<SubjectViewModel>().selectedSubject ==
                Subject.biology) ...[
              const CustomText(
                text: "NPCM",
              ),
            ]
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 7.5,
                crossAxisCount: 2, // Number of columns
                // mainAxisSpacing: 20.0, // Spacing between rows
              ),
              itemBuilder: (context, index) {
                return ChapterCard(index: index);
              },
              itemCount: context
                  .read<SubjectViewModel>()
                  .selectedSubjectModel!
                  .chapters
                  .length,
            ),
          ),
          const SingleChildScrollView(child: RevisionScreen()),
          if (context.read<SubjectViewModel>().selectedSubject ==
              Subject.biology) ...[const NpcmTopicsView()]
        ],
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
      appBar: AppBar(
        title: CustomText(
            text: context
                    .read<SubjectViewModel>()
                    .selectedSubjectModel
                    ?.subjectName ??
                ""),
        backgroundColor: AppColors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: IconThemeData(color: AppColors.black),
        bottom: TabBar(
          labelPadding: const EdgeInsets.all(8),
          indicatorColor: AppColors.primaryColor,
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          tabs: [
            const CustomText(
              text: AppStrings.practice,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: AppStrings.revision,
                ),
                7.horizontalSpace,
                // (context.watch<RevisionViewModel>().pendingQuestionCount != 0)
                //     ? Container(
                //         width: 10,
                //         height: 10,
                //         decoration: BoxDecoration(
                //             color: AppColors.primaryColor,
                //             shape: BoxShape.circle),
                //       )
                //     : const SizedBox()
              ],
            ),
            if (context.read<SubjectViewModel>().selectedSubject ==
                Subject.biology) ...[
              const CustomText(
                text: "NPCM",
              ),
            ]
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      20.verticalSpace,
                      ChapterCard(
                        index: index,
                      )
                    ],
                  );
                }
                if (index ==
                    context
                            .read<SubjectViewModel>()
                            .selectedSubjectModel!
                            .chapters
                            .length -
                        1) {
                  return Column(
                    children: [
                      ChapterCard(
                        index: index,
                      ),
                      60.verticalSpace,
                    ],
                  );
                }
                return ChapterCard(
                  index: index,
                );
              },
              itemCount: context
                  .read<SubjectViewModel>()
                  .selectedSubjectModel!
                  .chapters
                  .length,
            ),
          ),
          const SingleChildScrollView(child: RevisionScreen()),
          if (context.read<SubjectViewModel>().selectedSubject ==
              Subject.biology) ...[const NpcmTopicsView()]
        ],
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
