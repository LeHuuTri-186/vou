import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vou/shared/styles/horizontal_spacing.dart';
import 'package:vou/shared/widgets/image_icon.dart';

import '../../../../theme/color/colors.dart';

class SharedAppBarScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const SharedAppBarScaffold({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key ?? const ValueKey<String>('shared-header'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ImageIconWidget(imagePath: 'assets/images/profile.png'),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Ink(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Row(
                      children: [
                        ImageIconWidget(imagePath: 'assets/images/gem.png'),
                        HSpacing.sm,
                        Text("100"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Ink(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ImageIconWidget(imagePath: 'assets/images/lives.png'),
                        HSpacing.sm,
                        Text("5"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: child,
    );
  }
}