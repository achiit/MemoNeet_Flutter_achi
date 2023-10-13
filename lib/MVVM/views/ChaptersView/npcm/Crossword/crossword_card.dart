import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/MVVM/views/ChaptersView/npcm/Crossword/crossword_player.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/colors.dart';
import '../../../../viewmodels/npcm/npcm_view_model.dart';

class CrosswordCard extends StatelessWidget {
  final int index;
  const CrosswordCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.read<NpcmViewModel>().setSelectedCrossword = index;
        Navigator.pushNamed(
          context,
          CrosswordPlayer.route,
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
                            .listOfCrosswords[index]
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

// 1. create one hive box of type int 
//     - it will store 4 different types of keys
//           * "Subject_Name_key" it will store count of questions correctly attempted in that subject
//           * "Chapter_Name_key" it will store count of questions correctly attempted in that chapter
//           * "Topic_Name_key" it will store count of questions correctly attempted in that topic
//           * "SubTopic_Name_key" it will store count of questions correctly attempted in that subtopic
// 2. when user will attempt any question correctly then update the count of that particular keys 
//    from the hive box
// for example if user has attempted 2 questions correctly in subject "Biology"
// of topic_name Diversity in living world >> Animal Kingdom >> Porifera
// then we've to update all the 4 keys of hive box
//     * "biology" by 1
//     * "Diversity in living world" by 1
//     * "Diversity in living world >> Animal Kingdom_key" by 1
//     * "Diversity in living world >> Animal Kingdom_key >> Porifera_key" by 1






