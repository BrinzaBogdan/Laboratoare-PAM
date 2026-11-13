import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/product_sort.dart';

/// Deschide un bottom sheet cu opțiunile de sortare.
Future<void> showSortSheet(
  BuildContext context, {
  required ProductSort current,
  required ValueChanged<ProductSort> onSelected,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: kCard,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: kFieldFill,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sortează după',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: kDark,
                ),
              ),
              const SizedBox(height: 6),
              ...ProductSort.values.map(
                (option) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: option == current
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: kDark,
                    ),
                  ),
                  trailing: option == current
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: kGreen,
                          size: 21,
                        )
                      : null,
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    onSelected(option);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
