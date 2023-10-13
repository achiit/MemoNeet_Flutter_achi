// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/Podcast/podcast_card.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/widgets/text/custom_text.dart';
import '../../../../viewmodels/npcm/npcm_view_model.dart';

class PodcastView extends StatefulWidget {
  static const String route = "/podcast-view";
  const PodcastView({super.key});

  @override
  State<PodcastView> createState() {
    return _PodcastViewState();
  }
}

class _PodcastViewState extends State<PodcastView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: "Podcasts"),
        backgroundColor: AppColors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      backgroundColor: AppColors.white,
      body: (context.read<NpcmViewModel>().selectedNpcm!.listOfPodcasts.isEmpty)
          ? Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3),
                    child: const Text(
                      "Oops! It looks\nlike there's\nnothing here",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    AppImages.notFoundDog,
                  ),
                )
              ],
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Column(
                  children: List.generate(
                      context
                          .read<NpcmViewModel>()
                          .selectedNpcm!
                          .listOfPodcasts
                          .length, (index) {
                    return PodcastCard(
                      index: index,
                    );
                  }),
                ),
              ),
            ),
    );
  }
}
