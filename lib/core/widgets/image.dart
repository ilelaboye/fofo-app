import 'package:flutter/material.dart';

class LocalImage extends StatelessWidget {
  final String url;
  final double? height, width;
  final BoxFit? fit;
  const LocalImage(this.url,
      {this.height, this.width, this.fit = BoxFit.cover, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      url,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
