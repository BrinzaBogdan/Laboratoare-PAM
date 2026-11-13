import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/state_views.dart';
import '../../domain/entities/product.dart';
import '../cubit/catalog_cubit.dart';
import '../cubit/product_detail_cubit.dart';
import '../cubit/product_detail_state.dart';
import '../widgets/price_tag.dart';
import '../widgets/rating_badge.dart';
import '../widgets/review_tile.dart';
import '../widgets/spec_row.dart';

/// Ecranul de detalii, alimentat asincron de la serviciul Web.
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.preview});

  /// Produsul din listă, afișat imediat până sosesc detaliile complete.
  final Product preview;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        if (state.status == ProductDetailStatus.failure &&
            state.product == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Detalii produs')),
            body: ErrorView(
              message:
                  state.errorMessage ?? 'Produsul nu a putut fi încărcat.',
              onRetry: () =>
                  context.read<ProductDetailCubit>().load(preview.id),
            ),
          );
        }

        final product = state.product ?? preview;
        final isLoading = state.status == ProductDetailStatus.loading;
        final isFavorite =
            context.watch<CatalogCubit>().state.isFavorite(product.id);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 320,
                backgroundColor: kBackground,
                surfaceTintColor: Colors.transparent,
                leadingWidth: 60,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Center(
                    child: _CircleIconButton(
                      icon: Icons.arrow_back_rounded,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                actions: [
                  _CircleIconButton(
                    icon: isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isFavorite ? kDanger : kDark,
                    onTap: () =>
                        context.read<CatalogCubit>().toggleFavorite(product),
                  ),
                  const SizedBox(width: 14),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: _Gallery(
                    images: product.images.isEmpty
                        ? [product.thumbnail]
                        : product.images,
                  ),
                ),
              ),
              if (isLoading)
                const SliverToBoxAdapter(
                  child: LinearProgressIndicator(
                    minHeight: 2.5,
                    color: kGreen,
                    backgroundColor: kFieldFill,
                  ),
                ),
              SliverToBoxAdapter(child: _DetailsBody(product: product)),
            ],
          ),
          bottomNavigationBar: _BottomBar(product: product),
        );
      },
    );
  }
}

class _Gallery extends StatefulWidget {
  const _Gallery({required this.images});

  final List<String> images;

  @override
  State<_Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<_Gallery> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.images;

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          itemCount: images.length,
          onPageChanged: (index) => setState(() => _index = index),
          itemBuilder: (_, index) => AppImage(url: images[index]),
        ),
        if (images.length > 1)
          Positioned(
            bottom: 18,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                final selected = index == _index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: selected ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: selected
                        ? kGreen
                        : Colors.white.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}

class _DetailsBody extends StatelessWidget {
  const _DetailsBody({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: kGreen.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Echipament sportiv',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: kGreenDark,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: product.inStock
                      ? kGreen.withValues(alpha: 0.16)
                      : const Color(0xFFFFECEC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  product.availabilityStatus.isEmpty
                      ? (product.inStock ? 'În stoc' : 'Stoc epuizat')
                      : product.availabilityStatus,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: product.inStock ? kGreenDark : kDanger,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              color: kDark,
              height: 1.2,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              RatingBadge(
                rating: product.rating,
                reviewCount: product.reviews.length,
              ),
              const SizedBox(width: 10),
              Container(
                width: 3,
                height: 3,
                decoration: const BoxDecoration(
                  color: kGreyLight,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${product.stock} buc. în stoc',
                style: const TextStyle(fontSize: 12, color: kGrey),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              PriceTag(
                price: product.price,
                finalPrice: product.finalPrice,
                hasDiscount: product.hasDiscount,
                large: true,
              ),
              const Spacer(),
              if (product.hasDiscount)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: kGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '-${product.discountPercentage.round()}%',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: kDark,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 13,
              color: kDarkSoft,
              height: 1.55,
            ),
          ),
          if (product.tags.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: product.tags
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: kCard,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: kFieldFill),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(fontSize: 11, color: kGrey),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 22),
          const SectionTitle(title: 'Specificații'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kFieldFill),
            ),
            child: Column(
              children: [
                if (product.brand != null)
                  SpecRow(label: 'Brand', value: product.brand!),
                SpecRow(label: 'SKU', value: product.sku),
                SpecRow(label: 'Garanție', value: product.warrantyInformation),
                SpecRow(label: 'Livrare', value: product.shippingInformation),
                SpecRow(label: 'Retur', value: product.returnPolicy),
                if (product.weight != null)
                  SpecRow(label: 'Greutate', value: '${product.weight} kg'),
                SpecRow(
                  label: 'Cantitate minimă',
                  value: '${product.minimumOrderQuantity} buc.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          SectionTitle(
            title: 'Recenzii',
            trailing: Text(
              '${product.reviews.length}',
              style: const TextStyle(fontSize: 12, color: kGrey),
            ),
          ),
          const SizedBox(height: 10),
          if (product.reviews.isEmpty)
            const Text(
              'Acest produs nu are încă recenzii.',
              style: TextStyle(fontSize: 12.5, color: kGrey),
            )
          else
            ...product.reviews.map((review) => ReviewTile(review: review)),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Preț total',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: kGrey,
                  ),
                ),
                const SizedBox(height: 2),
                PriceTag(
                  price: product.price,
                  finalPrice: product.finalPrice,
                  hasDiscount: product.hasDiscount,
                  large: true,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('${product.title} a fost adăugat în coș.'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: kDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
            },
            icon: const Icon(Icons.shopping_bag_outlined, size: 19),
            label: const Text('Adaugă în coș'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.color = kDark,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.92),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, size: 20, color: color),
        ),
      ),
    );
  }
}
