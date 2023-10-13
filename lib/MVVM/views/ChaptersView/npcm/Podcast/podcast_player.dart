import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:memo_neet/MVVM/viewmodels/npcm/npcm_view_model.dart';
import 'package:memo_neet/constants/images.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:provider/provider.dart';

class PodcastPlayer extends StatefulWidget {
  static const String route = 'podcast-player';
  const PodcastPlayer({super.key});

  @override
  State<PodcastPlayer> createState() => _PodcastPlayerState();
}

class _PodcastPlayerState extends State<PodcastPlayer> {
  late Timer _timer;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<NpcmViewModel>().getPodcastUrl();
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDuration =
        formatDuration(context.read<NpcmViewModel>().player.duration);
    return WillPopScope(
      onWillPop: () async {
        context.read<NpcmViewModel>().stop();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          body: Stack(
        children: [
          Image.asset(
            AppImages.podcastPlayer,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 60,
            left: 25,
            child: InkWell(
              onTap: () {
                context.read<NpcmViewModel>().stop();
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.white,
                  ),
                  CustomText(
                    text: "Podcasts",
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    context.read<NpcmViewModel>().selectedPodcast.topic,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(
                              context.read<NpcmViewModel>().player.position),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                        Expanded(
                          child: Slider(
                            activeColor: Colors.white,
                            inactiveColor: const Color(0xFF254354),
                            min: 0,
                            max: context
                                    .watch<NpcmViewModel>()
                                    .player
                                    .duration
                                    ?.inSeconds
                                    .toDouble() ??
                                0,
                            value: context
                                .watch<NpcmViewModel>()
                                .player
                                .position
                                .inSeconds
                                .toDouble(),
                            onChanged: (value) {
                              setState(() {
                                context
                                    .read<NpcmViewModel>()
                                    .player
                                    .seek(Duration(seconds: value.toInt()));
                              });
                            },
                          ),
                        ),
                        Text(
                          formattedDuration,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<NpcmViewModel>().previous();
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      if (context.read<NpcmViewModel>().isLoading) ...[
                        const CircularProgressIndicator()
                      ] else ...[
                        MaterialButton(
                          onPressed: () {
                            if (context.read<NpcmViewModel>().isPlaying) {
                              context.read<NpcmViewModel>().pause();
                            } else {
                              context.read<NpcmViewModel>().resume();
                            }
                          },
                          shape: const CircleBorder(),
                          color: const Color(0xFF254354),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              context.watch<NpcmViewModel>().isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          context.read<NpcmViewModel>().next();
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  String formatDuration(Duration? duration) {
    if (duration == null) return '0:00';

    final minutes = duration.inMinutes;
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }
}
