import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.onSeeAll});

  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text('See All',
              style: TextStyle(
                  color: kGreen, fontSize: 16, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
