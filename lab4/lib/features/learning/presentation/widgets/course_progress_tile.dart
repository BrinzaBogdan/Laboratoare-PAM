import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/remote_svg_icon.dart';
import '../../domain/entities/learning_feed.dart';

/// Cardul unui curs din planul de învățare.
class CourseProgressTile extends StatelessWidget {
  const CourseProgressTile({
    super.key,
    required this.course,
    required this.onTap,
  });

  final CourseSummary course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kCard,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: kFieldFill,
                  borderRadius: BorderRadius.circular(13),
                ),
                alignment: Alignment.center,
                child: RemoteSvgIcon(
                  url: course.progressIconUrl,
                  size: 22,
                  fallbackIcon: Icons.school_outlined,
                  fallbackColor: kMuted,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            course.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: kInk,
                            ),
                          ),
                        ),
                        Text(
                          '${course.progressPercent}%',
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: kMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: LinearProgressIndicator(
                        value: course.progress.clamp(0, 1),
                        minHeight: 6,
                        backgroundColor: kFieldFill,
                        color: course.progress >= 1 ? kSuccess : kAccent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${course.progressLabel} lessons',
                      style: const TextStyle(fontSize: 11, color: kMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: kMutedLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
