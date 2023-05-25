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

class NetworkImg extends StatelessWidget {
  final String url;
  final double? height, width;
  final BoxFit? fit;
  const NetworkImg(this.url,
      {this.height, this.width, this.fit = BoxFit.cover, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: height,
      width: width,
      fit: fit,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => Image.asset(
        'assets/images/holder.jpg',
        height: height,
        width: width,
      ),
    );
  }
}
