import 'package:flutter/material.dart';

class ImageIconWidget extends StatelessWidget {
  const ImageIconWidget(
      {super.key, this.width, this.height, required this.imagePath});
  final double? width;
  final double? height;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 30,
      height: height ?? 30,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(imagePath), fit: BoxFit.contain)),
    );
  }
}
