import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/npcm/npcm_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MemesView extends StatelessWidget {
  static const String route = 'memes-view';
  const MemesView({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('memes'),
      onVisibilityChanged: (visibilityInfo) async {
        if (visibilityInfo.visibleFraction == 0) {
          await ScreenProtector.preventScreenshotOff();
          await ScreenProtector.protectDataLeakageWithBlurOff();
        } else {
          await ScreenProtector.preventScreenshotOn();
          await ScreenProtector.protectDataLeakageWithBlur();
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title: const CustomText(text: "Memes"),
            backgroundColor: AppColors.white,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios),
            ),
            iconTheme: IconThemeData(color: AppColors.black),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<NpcmViewModel>(
                  builder: (context, npcmViewModel, child) {
                    final imageUrls = npcmViewModel.memesUrl;

                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 350,
                            margin: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 18),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        imageUrls[index]),
                                    fit: BoxFit.fitWidth),
                                borderRadius: BorderRadius.circular(20)),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
