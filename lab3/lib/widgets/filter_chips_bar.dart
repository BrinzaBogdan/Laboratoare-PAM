import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/fitness_models.dart';

/// Bara orizontala de filtre (All Type, Pilates, Cardio, ...).
class FilterChipsBar extends StatelessWidget {
  const FilterChipsBar({
    super.key,
    required this.filters,
    required this.selectedId,
    required this.onSelected,
  });

  final List<FilterOption> filters;
  final String selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final f = filters[i];
          final selected = f.id == selectedId;
          return ChoiceChip(
            label: Text(f.name),
            selected: selected,
            onSelected: (_) => onSelected(f.id),
            showCheckmark: false,
            selectedColor: kGreen,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: selected ? Colors.white : kDark,
              fontWeight: FontWeight.w500,
            ),
            shape: StadiumBorder(
              side: BorderSide(
                color: selected ? kGreen : const Color(0xFFE3E5EA),
              ),
            ),
          );
        },
      ),
    );
  }
}
