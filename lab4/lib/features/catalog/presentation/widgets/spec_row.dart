import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

/// Un rând etichetă / valoare din secțiunea de specificații.
class SpecRow extends StatelessWidget {
  const SpecRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: kGrey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: kDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Titlul unei secțiuni, cu acțiune opțională în dreapta.
class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: kDark,
          ),
        ),
        const Spacer(),
        ?trailing,
      ],
    );
  }
}
