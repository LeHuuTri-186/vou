import 'package:flutter/material.dart';

class TAppBar {
  static AppBar buildAppBar({required BuildContext context, required String title}) {
    return AppBar(
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}