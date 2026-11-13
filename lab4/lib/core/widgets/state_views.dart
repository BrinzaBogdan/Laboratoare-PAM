import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Starea de încărcare, reutilizabilă în orice ecran.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message = 'Se încarcă datele...'});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
          const SizedBox(height: 14),
          Text(message, style: const TextStyle(color: kGrey, fontSize: 13)),
        ],
      ),
    );
  }
}

/// Starea de eroare, cu acțiune de reîncercare.
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFFFECEC),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.wifi_off_rounded, color: kDanger, size: 30),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ceva nu a funcționat',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: kDark,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kGrey, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Reîncearcă'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Starea fără rezultate.
class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    this.title = 'Niciun rezultat',
    this.message = 'Încearcă altă căutare sau alt filtru.',
    this.actionLabel = 'Resetează',
    this.onAction,
  });

  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: kFieldFill,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.search_off_rounded, color: kGrey, size: 30),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: kDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kGrey, fontSize: 13),
            ),
            if (onAction != null) ...[
              const SizedBox(height: 12),
              TextButton(onPressed: onAction, child: Text(actionLabel)),
            ],
          ],
        ),
      ),
    );
  }
}
