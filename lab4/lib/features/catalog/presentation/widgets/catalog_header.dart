import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

/// Antetul ecranului de catalog, cu acces la lista de favorite.
class CatalogHeader extends StatelessWidget {
  const CatalogHeader({
    super.key,
    required this.favoriteCount,
    required this.onOpenFavorites,
  });

  final int favoriteCount;
  final VoidCallback onOpenFavorites;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: kDark,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.fitness_center_rounded,
                color: kGreen,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SPORTSHOP',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.2,
                      color: kGrey,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Echipament de antrenament',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: kDark,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: onOpenFavorites,
                  icon: const Icon(Icons.favorite_rounded, color: kDark),
                ),
                if (favoriteCount > 0)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      constraints: const BoxConstraints(
                        minWidth: 17,
                        minHeight: 17,
                      ),
                      decoration: const BoxDecoration(
                        color: kDanger,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$favoriteCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kDark,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -14,
                bottom: -20,
                child: Icon(
                  Icons.sports_gymnastics_rounded,
                  size: 104,
                  color: kGreen.withValues(alpha: 0.18),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'NOUA COLECȚIE',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      color: kGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Construiește-ți\nurmătorul record.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.15,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Echipament sportiv ales pentru fiecare antrenament.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.white.withValues(alpha: 0.65),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
