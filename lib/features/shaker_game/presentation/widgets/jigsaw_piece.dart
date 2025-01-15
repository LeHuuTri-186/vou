import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../shared/styles/border_radius.dart';
import '../../../../shared/styles/box_shadow.dart';
import '../../../../theme/color/colors.dart';

class JigsawPiece extends StatelessWidget {
  final String imageUrl;
  final int index;
  final int totalPieces;
  final double scale;

  const JigsawPiece({
    required this.imageUrl,
    required this.index,
    required this.totalPieces, this.scale = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final int rows = _calculateRows(totalPieces);
    final int cols = (totalPieces / rows).ceil();
    final int row = index ~/ cols;
    final int col = index % cols;

    return FutureBuilder(
      future: _getImageSize(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final Size imageSize = snapshot.data as Size;

            final double widthFactor = (cols > 1) ? 1 / cols : 1.0;
            final double heightFactor = (rows > 1) ? 1 / rows : 1.0;

            final double alignmentX = (cols > 1)
                ? -1 + (2 * col / (cols - 1))
                : 0.0; // Center horizontally for 1 column
            final double alignmentY = (rows > 1)
                ? -1 + (2 * row / (rows - 1))
                : 0.0; // Center vertically for 1 row

            return Container(
              decoration: BoxDecoration(
                borderRadius: TBorderRadius.sm,
                color: TColor.doctorWhite,
                boxShadow: [TBoxShadow.normalBoxShadow],
              ),
              child: ClipRect(
                child: Align(
                  alignment: Alignment(alignmentX, alignmentY),
                  widthFactor: widthFactor,
                  heightFactor: heightFactor,
                  child: Image.network(
                    imageUrl,
                    width: imageSize.width / scale,
                    height: imageSize.height / scale,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('Failed to load image size.'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  int _calculateRows(int totalPieces) {
    return sqrt(totalPieces).toInt();
  }

  Future<Size> _getImageSize(String url) async {
    final Image image = Image.network(url);
    final Completer<Size> completer = Completer<Size>();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(info.image.width.toDouble(), info.image.height.toDouble()));
      }),
    );
    return completer.future;
  }
}
