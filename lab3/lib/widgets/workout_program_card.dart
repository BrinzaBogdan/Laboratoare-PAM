import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/fitness_models.dart';
import 'network_media.dart';

/// Card pentru un program de antrenament, cu favorite si badge Pro.
class WorkoutProgramCard extends StatelessWidget {
  const WorkoutProgramCard({
    super.key,
    required this.program,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onTap,
  });

  final WorkoutProgram program;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 260,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              NetworkImageBox(url: program.imageUrl),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xEE14161C)],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  onPressed: onToggleFavorite,
                  style: IconButton.styleFrom(backgroundColor: Colors.white24),
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.redAccent : Colors.white,
                  ),
                ),
              ),
              if (program.isPro)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.workspace_premium_outlined,
                            color: kGreen, size: 16),
                        SizedBox(width: 4),
                        Text('Pro',
                            style: TextStyle(
                                color: kGreen, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.local_fire_department_outlined,
                            color: Colors.white70, size: 16),
                        const SizedBox(width: 4),
                        Text('${program.calories} kcl',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13)),
                        const SizedBox(width: 12),
                        const Icon(Icons.access_time,
                            color: Colors.white70, size: 16),
                        const SizedBox(width: 4),
                        Text('${program.durationMinutes} min',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
