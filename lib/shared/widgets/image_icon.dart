import 'package:flutter/material.dart';

class ImageIconWidget extends StatelessWidget {
  const ImageIconWidget(
      {super.key,
      this.width,
      this.height,
      required this.imagePath,
      this.fit = BoxFit.contain});
  final double? width;
  final double? height;
  final String imagePath;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 30,
      height: height ?? 30,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imagePath), fit: fit)),
    );
  }
}
