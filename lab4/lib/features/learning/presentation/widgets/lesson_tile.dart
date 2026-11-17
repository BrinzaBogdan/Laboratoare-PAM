import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/remote_svg_icon.dart';
import '../../domain/entities/course_details.dart';

/// Un rând de lecție în ecranul „Course Overview”.
class LessonTile extends StatelessWidget {
  const LessonTile({super.key, required this.lesson, this.onTap});

  final Lesson lesson;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = !lesson.locked;

    return Material(
      color: kCard,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Row(
            children: [
              RemoteSvgIcon(
                url: lesson.playIconUrl,
                size: 34,
                fallbackIcon: Icons.play_circle_outline_rounded,
                fallbackColor: enabled ? kAccent : kMutedLight,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: enabled ? kInk : kMutedLight,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 12,
                          color: enabled ? kMuted : kMutedLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          lesson.duration,
                          style: TextStyle(
                            fontSize: 11.5,
                            color: enabled ? kMuted : kMutedLight,
                          ),
                        ),
                        if (lesson.completed) ...[
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 13,
                            color: kSuccess,
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: kSuccess,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (lesson.locked)
                const Icon(
                  Icons.lock_outline_rounded,
                  size: 18,
                  color: kMutedLight,
                )
              else
                RemoteSvgIcon(
                  url: lesson.arrowIconUrl,
                  size: 20,
                  fallbackIcon: Icons.chevron_right_rounded,
                  fallbackColor: kAccent,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
