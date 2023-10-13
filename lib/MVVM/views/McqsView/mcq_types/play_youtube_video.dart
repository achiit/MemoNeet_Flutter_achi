import 'package:flutter/material.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;

class PlayVideoFromYoutube extends StatefulWidget {
  final String videoId;
  const PlayVideoFromYoutube({Key? key, required this.videoId})
      : super(key: key);

  @override
  State<PlayVideoFromYoutube> createState() => _PlayVideoFromVimeoIdState();
}

class _PlayVideoFromVimeoIdState extends State<PlayVideoFromYoutube> {
  late final PodPlayerController controller;
  String videoTitle = "";

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        'https://youtu.be/${widget.videoId}',
      ),
      podPlayerConfig: const PodPlayerConfig(
        videoQualityPriority: [720, 360],
        autoPlay: false,
      ),
    )..initialise();
    _fetchVideoTitle();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          PodVideoPlayer(
            controller: controller,
            videoTitle: Container(
              padding: const EdgeInsets.only(left: 10),
              child: CustomText(
                text: videoTitle,
                color: Colors.white,
              ),
            ),
          ),
          40.verticalSpace,
          // _loadVideoFromUrl()
        ],
      ),
    );
  }

  void _fetchVideoTitle() async {
    youtube.YoutubeExplode youtubeExplode = youtube.YoutubeExplode();
    try {
      var video = await youtubeExplode.videos.get(widget.videoId);
      setState(() {
        videoTitle = video.title;
      });
    } catch (e) {
      snackBar("Failed to fetch video title.");
    } finally {
      youtubeExplode.close();
    }
  }

  void snackBar(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
  }
}
