import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/product.dart';
import '../cubit/catalog_cubit.dart';
import '../cubit/catalog_state.dart';
import 'price_tag.dart';

/// Deschide lista produselor favorite.
Future<void> showFavoritesSheet(
  BuildContext context, {
  required ValueChanged<Product> onOpen,
}) {
  final cubit = context.read<CatalogCubit>();

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: kCard,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return BlocProvider.value(
        value: cubit,
        child: _FavoritesSheetBody(onOpen: onOpen),
      );
    },
  );
}

class _FavoritesSheetBody extends StatelessWidget {
  const _FavoritesSheetBody({required this.onOpen});

  final ValueChanged<Product> onOpen;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        final favorites = state.favorites;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
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
                Row(
                  children: [
                    const Text(
                      'Favorite',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: kDark,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${favorites.length} produse',
                      style: const TextStyle(fontSize: 12, color: kGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (favorites.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    child: Column(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: const BoxDecoration(
                            color: kFieldFill,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            color: kGrey,
                            size: 26,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Nicio piesă salvată încă',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: kDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Apasă inima de pe un produs pentru a-l păstra aici.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: kGrey),
                        ),
                      ],
                    ),
                  )
                else
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.55,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: favorites.length,
                      separatorBuilder: (_, _) =>
                          const Divider(height: 18, color: kFieldFill),
                      itemBuilder: (context, index) {
                        final product = favorites[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            onOpen(product);
                          },
                          child: Row(
                            children: [
                              AppImage(
                                url: product.coverImage,
                                width: 52,
                                height: 52,
                                radius: BorderRadius.circular(12),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: kDark,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    PriceTag(
                                      price: product.price,
                                      finalPrice: product.finalPrice,
                                      hasDiscount: product.hasDiscount,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => context
                                    .read<CatalogCubit>()
                                    .toggleFavorite(product),
                                icon: const Icon(
                                  Icons.favorite_rounded,
                                  color: kDanger,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        );
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
}
