import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/npcm/npcm_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NotesView extends StatelessWidget {
  static const String route = 'notes-view';
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('notes'),
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
            title: const CustomText(text: 'Notes'),
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
                    final imageUrls = npcmViewModel.notesUrls;

                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      child: PageView.builder(
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, progress) => Stack(children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              height: 75,
                                              width: 75,
                                              child:
                                                  const CircularProgressIndicator(),
                                            )),
                                        Align(
                                            alignment: Alignment.center,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black12,
                                              radius: 40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Image.asset(
                                                  AppImages.appIcon,
                                                  height: 60,
                                                ),
                                              ),
                                            )),
                                      ]),
                              imageUrl: imageUrls[index]);
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
