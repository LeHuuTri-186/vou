import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vou/shared/widgets/buttons_pair.dart';

import '../../../shared/styles/appbar.dart';
import '../../../shared/styles/vertical_spacing.dart';
import '../../../shared/widgets/search_bar.dart';
import '../../event/presentation/widgets/category_chips_selector.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  bool _isFirstButtonSelected = true;

  void _toggleButtonSelection() {
    setState(() {
      _isFirstButtonSelected = !_isFirstButtonSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar.buildAppBar(context: context, title: 'Friend'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomSearchBar(
                onChanged: (value) {},
              ),
              VSpacing.sm,
              ButtonsPair(
                borderRadius: 8,
                isFirstSelected: _isFirstButtonSelected,
                firstOnTap: _toggleButtonSelection,
                secondOnTap: _toggleButtonSelection,
                firstButtonText: "Friend(s)",
                secondButtonText: "Friend request(s)",
              ),
              VSpacing.sm,
              _isFirstButtonSelected
                  ? Text('Showing Friends List')
                  : Text('Showing Friend Requests'),
            ],
          ),
        ),
      ),
    );
  }
}
