import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/state_views.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_detail.dart';
import '../cubit/catalog_cubit.dart';
import '../cubit/catalog_state.dart';
import '../cubit/product_detail_cubit.dart';
import '../widgets/catalog_header.dart';
import '../widgets/catalog_search_field.dart';
import '../widgets/favorites_sheet.dart';
import '../widgets/product_card.dart';
import '../widgets/sort_sheet.dart';
import 'product_detail_page.dart';

/// Ecranul principal: catalogul de echipament sportiv.
class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key, required this.getProductDetail});

  final GetProductDetail getProductDetail;

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 420) {
      context.read<CatalogCubit>().loadMore();
    }
  }

  void _openDetail(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
          create: (_) =>
              ProductDetailCubit(widget.getProductDetail)..load(product.id),
          child: ProductDetailPage(preview: product),
        ),
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<CatalogCubit>().clearQuery();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CatalogCubit>();

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<CatalogCubit, CatalogState>(
          builder: (context, state) {
            return RefreshIndicator(
              color: kGreen,
              onRefresh: cubit.refresh,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          CatalogHeader(
                            favoriteCount: state.favoriteCount,
                            onOpenFavorites: () => showFavoritesSheet(
                              context,
                              onOpen: _openDetail,
                            ),
                          ),
                          const SizedBox(height: 18),
                          CatalogSearchField(
                            controller: _searchController,
                            onChanged: cubit.onQueryChanged,
                            onClear: _clearSearch,
                          ),
                          const SizedBox(height: 14),
                          _CatalogToolbar(
                            state: state,
                            onSort: () => showSortSheet(
                              context,
                              current: state.sort,
                              onSelected: cubit.changeSort,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ..._buildContent(state, cubit),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildContent(CatalogState state, CatalogCubit cubit) {
    if (state.status == CatalogStatus.initial ||
        state.status == CatalogStatus.loading) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: LoadingView(),
          ),
        ),
      ];
    }

    if (state.status == CatalogStatus.failure) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: ErrorView(
            message: state.errorMessage ?? 'Catalogul nu a putut fi încărcat.',
            onRetry: cubit.retry,
          ),
        ),
      ];
    }

    if (state.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyView(
            title: state.isSearching
                ? 'Niciun produs găsit'
                : 'Catalogul este gol',
            message: state.isSearching
                ? 'Nu am găsit produse pentru „${state.query}”. Încearcă alt termen.'
                : 'Momentan nu există produse disponibile.',
            actionLabel: 'Resetează căutarea',
            onAction: state.isSearching ? _clearSearch : null,
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.68,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final product = state.products[index];
              return ProductCard(
                product: product,
                isFavorite: state.isFavorite(product.id),
                onTap: () => _openDetail(product),
                onToggleFavorite: () => cubit.toggleFavorite(product),
              );
            },
            childCount: state.products.length,
          ),
        ),
      ),
      SliverToBoxAdapter(child: _buildFooter(state, cubit)),
    ];
  }

  Widget _buildFooter(CatalogState state, CatalogCubit cubit) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2.2),
          ),
        ),
      );
    }

    if (state.loadMoreFailed) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Text(
              state.errorMessage ?? 'Încărcarea a eșuat.',
              style: const TextStyle(fontSize: 12, color: kGrey),
            ),
            TextButton(
              onPressed: cubit.loadMore,
              child: const Text('Reîncearcă'),
            ),
          ],
        ),
      );
    }

    if (state.isSearching) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Text(
          '${state.total} rezultate pentru „${state.query}”',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11.5, color: kGrey),
        ),
      );
    }

    if (!state.hasMore) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Text(
          'Ai ajuns la finalul catalogului',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11.5, color: kGrey),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _CatalogToolbar extends StatelessWidget {
  const _CatalogToolbar({required this.state, required this.onSort});

  final CatalogState state;
  final VoidCallback onSort;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.isSearching ? 'Rezultate' : 'Produse',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: kDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                state.isSearching
                    ? '${state.total} pentru „${state.query}”'
                    : '${state.total} produse disponibile',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11.5, color: kGrey),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: OutlinedButton.icon(
            onPressed: onSort,
            icon: const Icon(Icons.swap_vert_rounded, size: 17),
            label: Text(
              state.sort.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: kDark,
              backgroundColor: kCard,
              side: const BorderSide(color: kFieldFill),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
