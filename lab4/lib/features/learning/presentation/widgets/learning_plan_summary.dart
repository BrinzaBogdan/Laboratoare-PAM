import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/learning_feed.dart';

/// Rezumatul planului de învățare, calculat din cursurile primite de la API.
class LearningPlanSummary extends StatelessWidget {
  const LearningPlanSummary({
    super.key,
    required this.plan,
  });

  final LearningPlan plan;

  @override
  Widget build(BuildContext context) {
    final totalCompleted = plan.items.fold<int>(
      0,
      (sum, course) => sum + course.completed,
    );
    final totalLessons = plan.items.fold<int>(
      0,
      (sum, course) => sum + course.total,
    );
    final progress = totalLessons == 0 ? 0.0 : totalCompleted / totalLessons;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kDivider),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: kAccentSoft,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.auto_graph_rounded,
              color: kAccentDark,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${plan.items.length} courses in progress',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: kInk,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0, 1),
                    minHeight: 6,
                    backgroundColor: kFieldFill,
                    color: kAccent,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$totalCompleted/$totalLessons lessons completed',
                  style: const TextStyle(fontSize: 11, color: kMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
