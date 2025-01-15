import 'package:flutter/material.dart';
import '../../../../theme/color/colors.dart';

class CategoryChips extends StatefulWidget {
  final Map<String, String> categories; // Map of display text (key) to value
  final Function(List<String>)
  onSelectionChanged; // Callback with selected values
  final List<String>? selectedValues; // Initial selected values

  const CategoryChips({
    super.key,
    required this.categories,
    required this.onSelectionChanged,
    this.selectedValues,
  });

  @override
  _CategoryChipsState createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  late List<String> _selectedValues; // Internal state for selected values

  @override
  void initState() {
    super.initState();
    _selectedValues = widget.selectedValues ?? [];
  }

  void _toggleSelection(String value) {
    setState(() {
      // Check if the first value is selected and restrict other selections
      if (value != widget.categories.values.first &&
          _selectedValues.contains(widget.categories.values.first)) {
        _selectedValues.clear();
        _selectedValues.add(value);

        return;
      }

      // If selecting the first value, deselect others
      if (value == widget.categories.values.first &&
          !_selectedValues.contains(value)) {
        _selectedValues.clear();
        _selectedValues.add(value);

        return;
      }

      // Add or remove the selected value
      if (_selectedValues.contains(value)) {
        _selectedValues.remove(value);
      } else {
        _selectedValues.add(value);
      }
    });

    // Notify parent about the updated list of selected values
    widget.onSelectionChanged(_selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: widget.categories.entries.map((entry) {
        final displayText = entry.key;
        final value = entry.value;
        final isSelected = _selectedValues.contains(value);
        return ChoiceChip(
          side: isSelected
              ? BorderSide.none
              : BorderSide(color: TColor.petRock.withOpacity(0.3)),
          showCheckmark: false,
          label: Text(displayText),
          labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: isSelected ? TColor.doctorWhite : TColor.squidInk,
            fontWeight: FontWeight.w800,
            fontSize: 13,
          ),
          selectedColor: TColor.poppySurprise, // Highlight color for selected chip
          backgroundColor:
          TColor.doctorWhite, // Background for non-selected chips
          selected: isSelected,
          onSelected: (_) =>
              _toggleSelection(value), // Internal selection handler
        );
      }).toList(),
    );
  }
}
