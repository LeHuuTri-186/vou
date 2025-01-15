import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/box_shadow.dart';
import '../../../../theme/color/colors.dart';

class ImagePiecesGrid extends StatelessWidget {
  final String imageUrl;
  final int totalPieces;
  final double scale;

  const ImagePiecesGrid({
    required this.imageUrl,
    required this.totalPieces, this.scale = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate rows and columns based on totalPieces
    final int rows = _calculateRows(totalPieces);
    final int cols = (totalPieces / rows).ceil();

    return FutureBuilder(
      future: _getImageSize(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final Size imageSize = snapshot.data as Size;

            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                  totalPieces, (index) {
                final int row = index ~/ cols;
                final int col = index % cols;
                return ImagePiece(
                  imageUrl: imageUrl,
                  row: row,
                  col: col,
                  rows: rows,
                  cols: cols,
                  scale: scale,
                );
              }),
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
    // Get the square root of totalPieces and round down to get the number of rows
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

class ImagePiece extends StatelessWidget {
  final String imageUrl;
  final int row;
  final int col;
  final int rows;
  final int cols;
  final double scale;

  const ImagePiece({
    required this.imageUrl,
    required this.row,
    required this.col,
    required this.rows,
    required this.cols,
    this.scale = 5,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getImageSize(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final Size imageSize = snapshot.data as Size;

            // Avoid division by zero
            final double widthFactor = (cols > 1) ? 1 / cols : 1.0;
            final double heightFactor = (rows > 1) ? 1 / rows : 1.0;

            // Alignment logic with special case for 1 row or 1 column
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
