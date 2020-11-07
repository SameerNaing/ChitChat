import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:meta/meta.dart';

class ImageViewWidget extends StatelessWidget {
  final String imageUrl;
  ImageViewWidget({Key key, @required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Hero(
      tag: imageUrl,
      child: PhotoView(
        imageProvider: NetworkImage(imageUrl),
      ),
    ));
  }
}
