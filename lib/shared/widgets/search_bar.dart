import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/varela_round_style.dart';

class CustomSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const CustomSearchBar({
    super.key,
    required this.onChanged,
    this.hintText = "Search...",
  });

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onChanged(_controller.text);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColor.grahamHair,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        style: WorkSansStyle.basicW600.copyWith(
          color: TColor.squidInk,
          fontSize: 15,
        ),
        cursorColor: TColor.squidInk,
        controller: _controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: TColor.tamarama.withOpacity(0.5),
              )),
          hintText: widget.hintText,
          hintStyle: WorkSansStyle.basic.copyWith(
            color: TColor.petRock,
            fontSize: 15
          ),
          prefixIcon: Icon(
            Icons.search,
            color: TColor.squidInk,
          ),
          suffixIcon: _controller.text.trim().isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: TColor.petRock,
                  ),
                  onPressed: () {
                    _controller.clear();
                    widget.onChanged(""); // Clear the search text
                  },
                )
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
