import 'package:flutter/material.dart';
import 'package:vou/shared/styles/appbar.dart';
import '../widgets/app_drawer.dart';

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
      appBar: TAppBar.buildAppBar(context: context, title: title),
      body: child,
      drawer: AppDrawer(),
      onDrawerChanged: (isOpened) {
        if (isOpened) {
          FocusScope.of(context).unfocus();
        }
      },
    );
  }
}