import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/remote_svg_icon.dart';
import '../../domain/entities/learning_feed.dart';

/// Antetul feed-ului: avatar, salut, subtitlu și notificare.
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    super.key,
    required this.header,
    this.onNotificationTap,
  });

  final LearningHeader header;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: AppImage(
            url: header.avatarUrl,
            width: 50,
            height: 50,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                header.greeting,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: kInk,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                header.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12.5, color: kMuted),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              color: kCard,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onNotificationTap,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: RemoteSvgIcon(
                      url: header.notificationIconUrl,
                      size: 21,
                      fallbackIcon: Icons.notifications_none_rounded,
                      fallbackColor: kInk,
                    ),
                  ),
                ),
              ),
            ),
            if (header.hasUnread)
              Positioned(
                top: 9,
                right: 9,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: kAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: kCard, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
