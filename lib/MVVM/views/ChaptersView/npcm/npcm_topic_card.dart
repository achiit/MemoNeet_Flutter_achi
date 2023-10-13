// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/navigation/navigation_view_model.dart';
import 'package:memo_neet/MVVM/viewmodels/npcm/npcm_view_model.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/navigator/page_navigator.dart';
import 'package:memo_neet/utils/widgets/popup_dialog/custom_dialog.dart';
import 'package:provider/provider.dart';

import 'npcm_view.dart';

class NpcmTopicCard extends StatefulWidget {
  final int index;

  const NpcmTopicCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<NpcmTopicCard> createState() => _NpcmTopicCardState();
}

class _NpcmTopicCardState extends State<NpcmTopicCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationBarIndex = Provider.of<NavigationViewModel>(context);
    return GestureDetector(
      onTap: () async {
        await context.read<NpcmViewModel>().setSelectedNpcm(widget.index);
        if (context.read<UserViewModel>().isSubscribedUser ||
            context.read<NpcmViewModel>().npcmTopics[widget.index].isFree) {
          PageNavigator(ctx: context).nextPage(page: const NPCMView());
        } else {
          dialogForSubscription(context, providerValue: navigationBarIndex);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(6),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                              .npcmTopics[widget.index]
                              .chapterName,
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
              if (context.watch<UserViewModel>().isSubscribedUser ||
                  context
                      .read<NpcmViewModel>()
                      .npcmTopics[widget.index]
                      .isFree) ...[
                const Expanded(
                    child: Icon(
                  FontAwesomeIcons.angleRight,
                  size: 18,
                )),
              ] else
                const Expanded(child: Icon(Icons.lock, color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
