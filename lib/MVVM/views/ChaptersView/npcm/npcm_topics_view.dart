import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/npcm/npcm_view_model.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/npcm_topic_card.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/repo/ad_mob_service.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:provider/provider.dart';

class NpcmTopicsView extends StatefulWidget {
  static const String route = "/npcm-topics-screen";

  const NpcmTopicsView({Key? key}) : super(key: key);

  @override
  State<NpcmTopicsView> createState() => _NpcmTopicsViewState();
}

class _NpcmTopicsViewState extends State<NpcmTopicsView>
    with TickerProviderStateMixin {
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<NpcmViewModel>().getNpcmData();
      setState(() {});
    });
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
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 7,
              crossAxisCount:
                  3, // Set the number of columns you want in the grid
            ),
            itemBuilder: (context, index) {
              return NpcmTopicCard(
                index: index,
              );
            },
            itemCount: context.read<NpcmViewModel>().npcmTopics.length,
          )),
    );
  }

  Scaffold mobileView(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  20.verticalSpace,
                  NpcmTopicCard(
                    index: index,
                  )
                ],
              );
            }
            if (index == context.read<NpcmViewModel>().npcmTopics.length - 1) {
              return Column(
                children: [
                  NpcmTopicCard(
                    index: index,
                  ),
                  60.verticalSpace,
                ],
              );
            }
            return NpcmTopicCard(
              index: index,
            );
          },
          itemCount: context.read<NpcmViewModel>().npcmTopics.length,
        ),
      ),
    );
  }
}
