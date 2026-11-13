import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';
import '../../domain/entities/product_sort.dart';

enum CatalogStatus { initial, loading, success, failure }

/// Starea ecranului de catalog.
///
/// Este imutabilă: fiecare schimbare produce o stare nouă, ceea ce face
/// rebuild-ul interfeței predictibil.
class CatalogState extends Equatable {
  const CatalogState({
    this.status = CatalogStatus.initial,
    this.products = const [],
    this.total = 0,
    this.query = '',
    this.sort = ProductSort.featured,
    this.favorites = const [],
    this.errorMessage,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.loadMoreFailed = false,
  });

  final CatalogStatus status;
  final List<Product> products;
  final int total;
  final String query;
  final ProductSort sort;
  final List<Product> favorites;
  final String? errorMessage;
  final bool isLoadingMore;
  final bool hasMore;
  final bool loadMoreFailed;

  bool get isEmpty => status == CatalogStatus.success && products.isEmpty;

  bool get isSearching => query.isNotEmpty;

  int get favoriteCount => favorites.length;

  bool isFavorite(int productId) =>
      favorites.any((product) => product.id == productId);

  CatalogState copyWith({
    CatalogStatus? status,
    List<Product>? products,
    int? total,
    String? query,
    ProductSort? sort,
    List<Product>? favorites,
    String? errorMessage,
    bool clearError = false,
    bool? isLoadingMore,
    bool? hasMore,
    bool? loadMoreFailed,
  }) {
    return CatalogState(
      status: status ?? this.status,
      products: products ?? this.products,
      total: total ?? this.total,
      query: query ?? this.query,
      sort: sort ?? this.sort,
      favorites: favorites ?? this.favorites,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      loadMoreFailed: loadMoreFailed ?? this.loadMoreFailed,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        total,
        query,
        sort,
        favorites,
        errorMessage,
        isLoadingMore,
        hasMore,
        loadMoreFailed,
      ];
}
