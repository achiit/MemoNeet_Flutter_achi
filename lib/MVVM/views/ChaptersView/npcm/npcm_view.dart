import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/viewmodels/npcm/npcm_view_model.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/Crossword/crossword_view.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/Memes/memes_view.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/Notes/notes_view.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

import 'Podcast/podcast_view.dart';

class NPCMView extends StatelessWidget {
  static const String route = 'npcm-view';
  const NPCMView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: CustomText(
            text:
                context.read<NpcmViewModel>().selectedNpcm?.chapterName ?? ""),
        backgroundColor: AppColors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      body: GridView.count(
        primary: false,
        childAspectRatio: 1.2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        children: <Widget>[
          npcmCard(
              title: "Notes",
              image: AppImages.notes,
              onTap: () {
                try {
                  context.read<NpcmViewModel>().getNotesUrl();
                } catch (e) {
                  showSnackBar(
                      context: context, message: "unable to load notes");
                }
                Navigator.pushNamed(
                  context,
                  NotesView.route,
                );
              }),
          npcmCard(
            title: "Podcast",
            image: AppImages.podcasts,
            onTap: () {
              Navigator.pushNamed(
                context,
                PodcastView.route,
              );
            },
          ),
          npcmCard(
              title: "Crosswords",
              image: AppImages.crosswords,
              onTap: () {
                Navigator.pushNamed(context, CrosswordView.route);
              }),
          npcmCard(
              title: "Memes",
              image: AppImages.memes,
              onTap: () {
                context.read<NpcmViewModel>().getMemesUrls();
                Navigator.pushNamed(context, MemesView.route);
              }),
        ],
      ),
    );
  }

  Widget npcmCard(
      {required String title, required String image, Function()? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      splashColor: Colors.blue.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: const Color(0x335E18EA),
          ),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image),
            16.verticalSpace,
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
