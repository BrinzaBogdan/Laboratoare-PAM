import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

/// Afișează prețul final și, dacă există, prețul iniștăiat.
class PriceTag extends StatelessWidget {
  const PriceTag({
    super.key,
    required this.price,
    required this.finalPrice,
    this.hasDiscount = false,
    this.large = false,
  });

  final double price;
  final double finalPrice;
  final bool hasDiscount;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '\$${finalPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: large ? 24 : 15,
            fontWeight: FontWeight.w800,
            color: kDark,
            letterSpacing: -0.3,
          ),
        ),
        if (hasDiscount) ...[
          const SizedBox(width: 6),
          Padding(
            padding: EdgeInsets.only(bottom: large ? 3 : 1),
            child: Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: large ? 14 : 11,
                color: kGrey,
                decoration: TextDecoration.lineThrough,
                decorationColor: kGrey,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
