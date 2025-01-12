import 'package:flutter/material.dart';

import '../../../../theme/color/colors.dart';

class CategoryChips extends StatefulWidget {
  final List<String> categories;
  final Function(List<String>)
      onSelectionChanged; // Callback for the updated list of selected categories
  final List<String>? selectedCategories;

  const CategoryChips({
    Key? key,
    required this.categories,
    required this.onSelectionChanged,
    this.selectedCategories,
  }) : super(key: key);

  @override
  _CategoryChipsState createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  late List<String>
      _selectedCategories; // Internal state for selected categories

  @override
  void initState() {
    super.initState();
    _selectedCategories = widget.selectedCategories ?? [];
  }

  void _toggleSelection(String category) {
    setState(() {
      if (category != widget.categories.first &&
          _selectedCategories.contains(widget.categories.first)) {
        _selectedCategories.clear();
        _selectedCategories.add(category);

        return;
      }

      if (category == widget.categories.first &&
          !_selectedCategories.contains(category)) {
        _selectedCategories.clear();
        _selectedCategories.add(category);

        return;
      }

      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category); // Deselect if already selected
      } else {
        _selectedCategories.add(category); // Select if not selected
      }
    });

    // Notify parent about the updated list
    widget.onSelectionChanged(_selectedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: widget.categories.map((category) {
        final isSelected = _selectedCategories.contains(category);
        return ChoiceChip(
          side: isSelected
              ? BorderSide.none
              : BorderSide(color: TColor.petRock.withOpacity(0.3)),
          showCheckmark: false,
          label: Text(category),
          labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: isSelected ? TColor.doctorWhite : TColor.squidInk,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
          selectedColor:
              TColor.poppySurprise, // Highlight color for selected chip
          backgroundColor:
              TColor.doctorWhite, // Background for non-selected chips
          selected: isSelected,
          onSelected: (_) =>
              _toggleSelection(category), // Internal selection handler
        );
      }).toList(),
    );
  }
}
