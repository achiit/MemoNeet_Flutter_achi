import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewer extends StatefulWidget {
  final String imgUrl;

  const ImagePreviewer(this.imgUrl, {super.key});

  @override
  State<ImagePreviewer> createState() => _ImagePreviewerState();
}

class _ImagePreviewerState extends State<ImagePreviewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        filterQuality: FilterQuality.high,
        imageProvider: NetworkImage(
          widget.imgUrl,
        ),
      ),
    );
  }
}
