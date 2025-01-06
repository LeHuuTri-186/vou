import 'package:flutter/material.dart';
import '../../../../shared/styles/colors.dart';

class CollapsibleCategoryChips extends StatefulWidget {
  final List<String> categories; // List of categories
  final Function(String) onCategorySelected; // Callback for category selection

  const CollapsibleCategoryChips({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  _CollapsibleCategoryChipsState createState() =>
      _CollapsibleCategoryChipsState();
}

class _CollapsibleCategoryChipsState extends State<CollapsibleCategoryChips> {
  late String selectedCategory; // Holds the selected category
  bool isExpanded = false; // Tracks whether the chips are expanded

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.categories.isNotEmpty
        ? widget.categories[0]
        : ''; // Initialize selected category
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row for chips and arrow
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastEaseInToSlowEaseOut,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: _buildChips(),
                ),
              ),
            ),
            // Expand/Collapse Arrow Button
            InkWell(
              splashColor: TColor.northEastSnow,
              borderRadius: BorderRadius.circular(12),
              onTap: _toggleExpanded, // Call the toggle method
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  isExpanded
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded,
                  color: TColor.tamarama,
                  semanticLabel: isExpanded ? "Collapses" : "Expands",
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Toggles between expanded and collapsed states
  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  // Builds category chips
  List<Widget> _buildChips() {
    final chips = widget.categories.map((category) {
      final isSelected = selectedCategory == category;
      return ChoiceChip(
        side: BorderSide.none,
        showCheckmark: false,
        label: Text(category),
        labelStyle: TextStyle(
          color: isSelected ? TColor.doctorWhite : TColor.squidInk,
        ),
        selectedColor: TColor.tamarama, // Highlight color for selected chip
        backgroundColor: TColor.northEastSnow, // Background for non-selected chips
        selected: isSelected,
        onSelected: (_) => _selectCategory(category),
      );
    }).toList();

    // Show all chips if expanded; otherwise limit the visible chips
    return isExpanded ? chips : chips.take(4).toList();
  }

  // Updates the selected category
  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
    widget.onCategorySelected(category); // Call the external callback
  }
}
