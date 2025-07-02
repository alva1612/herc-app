
import 'package:flutter/material.dart';

class FilterChipData {
  final String label;
  final String value;

  FilterChipData({required this.label, required this.value});
}

class FilterChips extends StatelessWidget {
  final List<FilterChipData> chips;
  final List<FilterChipData> selectedChips;
  final void Function(bool, FilterChipData) onSelected;

  const FilterChips(
      {super.key,
      required this.chips,
      required this.onSelected,
      required this.selectedChips});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: chips.length,
      itemBuilder: (context, index) {
        FilterChipData chip = chips[index];
        return Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: FilterChip(
            label: Text(chip.label),
            selected: selectedChips.any((element) => element.value == chip.value),
            onSelected: (bool selected) {
              onSelected(selected, chip);
            },
          ),
        );
      },
    );
  }
}
