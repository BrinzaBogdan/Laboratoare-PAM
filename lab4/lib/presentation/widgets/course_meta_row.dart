import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/remote_svg_icon.dart';
import '../../domain/entities/course_details.dart';

/// Rândul de metadate: durată, număr de lecții și rating.
class CourseMetaRow extends StatelessWidget {
  const CourseMetaRow({
    super.key,
    required this.course,
    required this.icons,
  });

  final Course course;
  final CourseUiIcons icons;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MetaItem(
            iconUrl: icons.durationIconUrl,
            label: course.duration,
            fallbackIcon: Icons.schedule_rounded,
          ),
        ),
        Expanded(
          child: _MetaItem(
            iconUrl: icons.lessonsIconUrl,
            label: '${course.lessonCount} lessons',
            fallbackIcon: Icons.menu_book_outlined,
          ),
        ),
        Expanded(
          child: _MetaItem(
            iconUrl: icons.ratingIconUrl,
            label: course.rating.toStringAsFixed(1),
            fallbackIcon: Icons.star_rounded,
          ),
        ),
      ],
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({
    required this.iconUrl,
    required this.label,
    required this.fallbackIcon,
  });

  final String iconUrl;
  final String label;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RemoteSvgIcon(
          url: iconUrl,
          size: 17,
          fallbackIcon: fallbackIcon,
          fallbackColor: kMuted,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: kMuted,
            ),
          ),
        ),
      ],
    );
  }
}
