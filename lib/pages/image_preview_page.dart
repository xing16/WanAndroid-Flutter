import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wanandroid_flutter/utils/screen_utils.dart';

class ImagePreviewPage extends StatefulWidget {
  final List<String> imageUrls;
  final int currentIndex;

  ImagePreviewPage(this.imageUrls, this.currentIndex);

  @override
  State<StatefulWidget> createState() {
    return ImagePreviewPageState();
  }
}

class ImagePreviewPageState extends State<ImagePreviewPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.imageUrls[index]),
//                    heroAttributes: widget.heroTag.isNotEmpty
//                        ? PhotoViewHeroAttributes(tag: widget.heroTag)
//                        : null,
                  );
                },
                itemCount: widget.imageUrls.length,
                loadingChild: Container(),
                backgroundDecoration: null,
                pageController: PageController(
                  initialPage: currentIndex, // 进入时默认显示的第几页
                ),
                enableRotation: true,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            width: getScreenWidth(context),
            child: Center(
              child: Text(
                "${currentIndex + 1} / ${widget.imageUrls.length}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
