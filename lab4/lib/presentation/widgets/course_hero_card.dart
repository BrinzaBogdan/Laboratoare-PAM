import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/remote_svg_icon.dart';
import '../../domain/entities/course_details.dart';

/// Hero-ul cursului, cu etichetă, buton play și statistici.
class CourseHeroCard extends StatelessWidget {
  const CourseHeroCard({super.key, required this.hero, this.onPlay});

  final CourseHero hero;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppImage(url: hero.imageUrl),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x66101012), Color(0x00101012), Color(0xB3101012)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.45, 1],
              ),
            ),
          ),
          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                hero.label,
                style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                  color: kInk,
                ),
              ),
            ),
          ),
          Center(
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 2,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onPlay,
                child: SizedBox(
                  width: 62,
                  height: 62,
                  child: Center(
                    child: RemoteSvgIcon(
                      url: hero.playIconUrl,
                      size: 30,
                      fallbackIcon: Icons.play_arrow_rounded,
                      fallbackColor: kAccent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 14,
            child: Row(
              children: [
                _HeroStat(
                  icon: Icons.videocam_outlined,
                  label: '${hero.videoCount} videos',
                ),
                const SizedBox(width: 8),
                _HeroStat(
                  icon: Icons.groups_outlined,
                  label: '${hero.classCount} classes',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
