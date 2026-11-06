import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/fitness_models.dart';
import '../widgets/amenity_tile.dart';
import '../widgets/network_media.dart';

/// Pagina de detalii a salii (pagina a doua din aplicatie).
class GymDetailsScreen extends StatefulWidget {
  const GymDetailsScreen({super.key, required this.gym});

  final GymDetails gym;

  @override
  State<GymDetailsScreen> createState() => _GymDetailsScreenState();
}

class _GymDetailsScreenState extends State<GymDetailsScreen> {
  bool _expanded = false;

  String _formatCount(int n) =>
      n.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');

  @override
  Widget build(BuildContext context) {
    final gym = widget.gym;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    NetworkImageBox(
                      url: gym.heroImageUrl,
                      height: 380,
                      width: double.infinity,
                    ),
                    SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _RoundButton(
                              icon: Icons.arrow_back,
                              onTap: () => Navigator.pop(context),
                            ),
                            _RoundButton(icon: Icons.more_vert, onTap: () {}),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: Color(0xFFFFB648), size: 24),
                          const SizedBox(width: 6),
                          Text(gym.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 4),
                          Text('(${_formatCount(gym.reviewCount)} reviews)',
                              style:
                                  const TextStyle(color: kGrey, fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(gym.name,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(gym.location,
                          style: const TextStyle(color: kGrey, fontSize: 16)),
                      const Divider(height: 32),
                      _Description(
                        text: gym.description,
                        expanded: _expanded,
                        onToggle: () => setState(() => _expanded = !_expanded),
                      ),
                      const SizedBox(height: 24),
                      const Text('Amenities',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 14),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 2.9,
                        children: gym.amenities
                            .map((a) => AmenityTile(amenity: a))
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _BottomBar(price: gym.priceText, label: gym.reserveLabel),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required this.text,
    required this.expanded,
    required this.onToggle,
  });

  final String text;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines: expanded ? null : 3,
          overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: const TextStyle(color: kGrey, fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: onToggle,
          child: Text(
            expanded ? 'Show less' : 'Read more',
            style: const TextStyle(
                color: kGreen, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.price, required this.label});

  final String price;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, -4)),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Total', style: TextStyle(color: kGrey, fontSize: 16)),
              const SizedBox(height: 4),
              Text(price,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700)),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 170,
            height: 58,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Rezervare trimisă!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(label,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      style: IconButton.styleFrom(backgroundColor: Colors.white24),
      icon: Icon(icon, color: Colors.white),
    );
  }
}
