// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIcon extends StatelessWidget {
  final String imageUrl;
  final String url;

  const SocialIcon({
    super.key,
    required this.url,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(
            url,
            universalLinksOnly: true,
          );
        } else {
          throw 'There was a problem to open the url: $url';
        }
      },
      child: Image.asset(
        imageUrl,
        height: 30,
        width: 30,
      ),
    );
  }
}
