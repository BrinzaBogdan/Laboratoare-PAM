import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/course_details.dart';

/// Bara fixă de jos, cu prețul și acțiunea de înscriere.
class EnrollBar extends StatelessWidget {
  const EnrollBar({
    super.key,
    required this.actions,
    required this.onEnroll,
  });

  final CourseActions actions;
  final VoidCallback onEnroll;

  @override
  Widget build(BuildContext context) {
    final enabled = actions.enroll.enabled;

    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        12 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: kCard,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                actions.price.label,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: kInk,
                  letterSpacing: -0.4,
                ),
              ),
              if (actions.price.currency.isNotEmpty)
                Text(
                  actions.price.currency,
                  style: const TextStyle(fontSize: 11, color: kMuted),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: FilledButton(
              onPressed: enabled ? onEnroll : null,
              style: FilledButton.styleFrom(
                backgroundColor: kAccent,
                foregroundColor: Colors.white,
                disabledBackgroundColor: kFieldFill,
                disabledForegroundColor: kMutedLight,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                actions.enroll.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
