import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/Podcast/podcast_player.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/colors.dart';
import '../../../../viewmodels/npcm/npcm_view_model.dart';

class PodcastCard extends StatelessWidget {
  final int index;
  const PodcastCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.read<NpcmViewModel>().setSelectedPodcast = index;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PodcastPlayer(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF858585).withOpacity(0.1),
                offset: const Offset(1, 1),
                blurRadius: 44,
                spreadRadius: 0,
              ),
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text(
                        context
                            .read<NpcmViewModel>()
                            .selectedNpcm!
                            .listOfPodcasts[index]
                            .topic,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.headingColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(
                child: Icon(
              FontAwesomeIcons.angleRight,
              size: 16,
            )),
          ],
        ),
      ),
    );
  }
}
