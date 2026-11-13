import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Imagine de rețea cu indicator de încărcare și fallback.
///
/// Componentă reutilizabilă în carduri, galerii și ecranul de detalii.
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _Placeholder(
          width: width,
          height: height,
          child: const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (context, error, stack) => _Placeholder(
        width: width,
        height: height,
        child: const Icon(Icons.image_not_supported_outlined, color: kGrey),
      ),
    );

    if (radius == null) return image;
    return ClipRRect(borderRadius: radius!, child: image);
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.child,
    this.width,
    this.height,
  });

  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: kFieldFill,
      alignment: Alignment.center,
      child: child,
    );
  }
}
