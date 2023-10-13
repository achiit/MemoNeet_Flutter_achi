import 'package:flutter/material.dart';
import 'package:memo_neet/constants/colors.dart';
import 'package:memo_neet/utils/widgets/mcqs/video/youtube_video_player.dart';
import 'package:memo_neet/utils/widgets/spacing/spacing.dart';
import 'package:memo_neet/utils/widgets/text/custom_text.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoType extends StatefulWidget {
  final String url;
  const VideoType({Key? key, required this.url}) : super(key: key);
  @override
  State<VideoType> createState() => _VideoTypeState();
}

class _VideoTypeState extends State<VideoType> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: MediaQuery.of(context).orientation == Orientation.landscape
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.height * .3,
          child: YoutubePlayerScreen("https://youtu.be/${widget.url}")),
    );
  }
}

class YoutubePlayerScreen extends StatefulWidget {
  final String url;

  const YoutubePlayerScreen(this.url, {super.key});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ZBotToast.loadingShow();
      _controller = YoutubePlayerController(
        initialVideoId: widget.url.split("/").last,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
      setState(() {});
      // ZBotToast.loadingClose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _controller != null
          ? YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: AppColors.primaryColor,
                topActions: <Widget>[
                  2.horizontalSpace,
                  Expanded(
                    child: CustomText(
                      text: _controller!.metadata.title,
                      color: Colors.white,
                      fontSize: 18.0,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  // IconButton(
                  //   icon: const Icon(
                  //     Icons.settings,
                  //     color: Colors.white,
                  //     size: 25.0,
                  //   ),
                  //   onPressed: () {
                  //     log('Settings Tapped!');
                  //   },
                  // ),
                ],
                onReady: () {},
                onEnded: (data) {},
              ),
              builder: (context, player) {
                return SizedBox(
                  height: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? MediaQuery.of(context).size.height * .8
                      : MediaQuery.of(context).size.height * .7,
                  child: Column(
                    children: [
                      YoutubeVideoPlayerScreen(
                        videoUrl: widget.url.split("/").last,
                      ),
                    ],
                  ),
                );
              })
          : const SizedBox(),
    );
  }
}
