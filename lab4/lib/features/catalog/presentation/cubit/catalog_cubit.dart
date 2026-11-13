import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_sort.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/search_products.dart';
import 'catalog_state.dart';

/// Coordonează fluxul UI -> use case -> repository -> API și înapoi.
///
/// Nu cunoaște HTTP, JSON sau widget-uri: depinde doar de cazurile de
/// utilizare din `domain`.
class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit({
    required this.getProducts,
    required this.searchProducts,
  }) : super(const CatalogState());

  final GetProducts getProducts;
  final SearchProducts searchProducts;

  static const int pageSize = 6;

  Timer? _debounce;

  /// Identificatorul ultimei cereri, folosit pentru a ignora răspunsurile
  /// întârziate atunci când utilizatorul schimbă rapid căutarea.
  int _requestId = 0;

  Future<void> load() async {
    final requestId = ++_requestId;
    final searching = state.query.isNotEmpty;

    emit(
      state.copyWith(
        status: CatalogStatus.loading,
        products: const [],
        total: 0,
        hasMore: false,
        isLoadingMore: false,
        loadMoreFailed: false,
        clearError: true,
      ),
    );

    try {
      final page = searching
          ? await searchProducts(query: state.query, limit: 100)
          : await getProducts(limit: pageSize, skip: 0, sort: state.sort);

      if (isClosed || requestId != _requestId) return;

      emit(
        state.copyWith(
          status: CatalogStatus.success,
          products: page.items,
          total: page.total,
          hasMore: searching ? false : page.hasMore,
          clearError: true,
        ),
      );
    } on Failure catch (failure) {
      if (isClosed || requestId != _requestId) return;
      emit(
        state.copyWith(
          status: CatalogStatus.failure,
          errorMessage: failure.message,
        ),
      );
    }
  }

  Future<void> refresh() => load();

  Future<void> retry() => load();

  /// Încarcă următoarea pagină la scroll.
  Future<void> loadMore() async {
    if (state.status != CatalogStatus.success ||
        state.isLoadingMore ||
        !state.hasMore ||
        state.query.isNotEmpty) {
      return;
    }

    final requestId = _requestId;
    emit(state.copyWith(isLoadingMore: true, loadMoreFailed: false));

    try {
      final page = await getProducts(
        limit: pageSize,
        skip: state.products.length,
        sort: state.sort,
      );

      if (isClosed || requestId != _requestId) return;

      emit(
        state.copyWith(
          products: [...state.products, ...page.items],
          total: page.total,
          hasMore: page.hasMore,
          isLoadingMore: false,
        ),
      );
    } on Failure catch (failure) {
      if (isClosed || requestId != _requestId) return;
      emit(
        state.copyWith(
          isLoadingMore: false,
          loadMoreFailed: true,
          errorMessage: failure.message,
        ),
      );
    }
  }

  /// Caută cu debounce, ca să nu trimitem o cerere la fiecare tastă.
  void onQueryChanged(String value) {
    final query = value.trim();
    if (query == state.query) return;

    emit(state.copyWith(query: query, clearError: true));
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), load);
  }

  Future<void> clearQuery() async {
    _debounce?.cancel();
    if (state.query.isEmpty) return;
    emit(state.copyWith(query: '', clearError: true));
    await load();
  }

  Future<void> changeSort(ProductSort sort) async {
    if (sort == state.sort) return;
    emit(state.copyWith(sort: sort));
    await load();
  }

  void toggleFavorite(Product product) {
    final favorites = [...state.favorites];
    if (state.isFavorite(product.id)) {
      favorites.removeWhere((item) => item.id == product.id);
    } else {
      favorites.insert(0, product);
    }
    emit(state.copyWith(favorites: favorites));
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
