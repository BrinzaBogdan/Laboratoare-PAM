import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Iconiță SVG din rețea (ex. Iconify), cu dimensiune fixă.
///
/// Serviciul Web livrează iconițele ca URL-uri SVG, deci nu pot fi afișate
/// cu `Image.network`. Componenta este refolosită în header, carduri și
/// ecranul de detalii.
class RemoteSvgIcon extends StatelessWidget {
  const RemoteSvgIcon({
    super.key,
    required this.url,
    this.size = 24,
    this.fallbackIcon = Icons.circle_outlined,
    this.fallbackColor,
  });

  final String url;
  final double size;
  final IconData fallbackIcon;
  final Color? fallbackColor;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Icon(fallbackIcon, size: size, color: fallbackColor);
    }

    return SvgPicture.network(
      url,
      width: size,
      height: size,
      placeholderBuilder: (_) => SizedBox(width: size, height: size),
      errorBuilder: (_, _, _) =>
          Icon(fallbackIcon, size: size, color: fallbackColor),
    );
  }
}
