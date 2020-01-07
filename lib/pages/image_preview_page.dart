import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePreviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImagePreviewPageState();
  }
}

class ImagePreviewPageState extends State<ImagePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: AssetImage("images/avatar.jpeg"),
          );
        },
        itemCount: 20,
      ),
    );
  }
}
