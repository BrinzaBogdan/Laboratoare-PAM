import 'package:flutter/material.dart';

import '../models/fitness_models.dart';
import 'network_media.dart';

class AmenityTile extends StatelessWidget {
  const AmenityTile({super.key, required this.amenity});

  final Amenity amenity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E8EC)),
      ),
      child: Row(
        children: [
          NetworkSvgIcon(url: amenity.iconUrl, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              amenity.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
