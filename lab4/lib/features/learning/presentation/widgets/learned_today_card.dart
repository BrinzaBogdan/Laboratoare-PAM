import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/learning_feed.dart';

/// Cardul „Learned today”, cu progresul zilei.
class LearnedTodayCard extends StatelessWidget {
  const LearnedTodayCard({super.key, required this.data});

  final LearnedToday data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: kMuted,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: kAccentSoft,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${data.progressPercent}%',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: kAccentDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            data.formatted,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: kInk,
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: data.progress.clamp(0, 1),
              minHeight: 8,
              backgroundColor: kFieldFill,
              color: kAccent,
            ),
          ),
        ],
      ),
    );
  }
}
