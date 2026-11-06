import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Imagine din retea, cu placeholder cat timp se incarca sau daca esueaza.
class NetworkImageBox extends StatelessWidget {
  const NetworkImageBox({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.radius = 0,
  });

  final String url;
  final double? height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        url,
        height: height,
        width: width,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) =>
            progress == null ? child : _Placeholder(height: height, width: width),
        errorBuilder: (context, error, stackTrace) =>
            _Placeholder(height: height, width: width),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: const Color(0xFF2B2E37),
      alignment: Alignment.center,
      child: const Icon(Icons.image_outlined, color: Colors.white24, size: 40),
    );
  }
}

/// Icon SVG din retea (ex. Iconify), cu dimensiune fixa.
class NetworkSvgIcon extends StatelessWidget {
  const NetworkSvgIcon({super.key, required this.url, this.size = 24});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      url,
      width: size,
      height: size,
      placeholderBuilder: (_) => SizedBox(width: size, height: size),
      errorBuilder: (_, __, ___) => SizedBox(width: size, height: size),
    );
  }
}
