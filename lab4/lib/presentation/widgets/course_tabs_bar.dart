import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/course_details.dart';

/// Selectorul de tab-uri Lessons / Description.
class CourseTabsBar extends StatelessWidget {
  const CourseTabsBar({
    super.key,
    required this.tabs,
    required this.selectedId,
    required this.onSelected,
  });

  final CourseTabs tabs;
  final String selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < tabs.items.length; index++) ...[
          if (index > 0) const SizedBox(width: 8),
          Expanded(
            child: _TabButton(
              tab: tabs.items[index],
              selected: tabs.items[index].id == selectedId,
              onTap: () => onSelected(tabs.items[index].id),
            ),
          ),
        ],
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final CourseTab tab;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? kInk : kFieldFill,
      borderRadius: BorderRadius.circular(11),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Text(
            tab.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : kMuted,
            ),
          ),
        ),
      ),
    );
  }
}
