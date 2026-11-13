import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_page.dart';
import '../../domain/entities/product_sort.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

/// Implementarea contractului din `domain`.
///
/// Traduce orice eroare neașteptată (inclusiv JSON invalid) într-un
/// `Failure`, ca stratul de prezentare să primească doar erori de business.
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<ProductPage> getProducts({
    required int limit,
    required int skip,
    required ProductSort sort,
  }) async {
    try {
      return await _remoteDataSource.fetchProducts(
        limit: limit,
        skip: skip,
        sort: sort,
      );
    } on Failure {
      rethrow;
    } catch (_) {
      throw const ParseFailure('Produsele primite nu au putut fi citite.');
    }
  }

  @override
  Future<ProductPage> searchProducts({
    required String query,
    required int limit,
  }) async {
    try {
      return await _remoteDataSource.searchProducts(
        query: query,
        limit: limit,
      );
    } on Failure {
      rethrow;
    } catch (_) {
      throw const ParseFailure('Rezultatele căutării nu au putut fi citite.');
    }
  }

  @override
  Future<Product> getProductById(int id) async {
    try {
      return await _remoteDataSource.fetchProductById(id);
    } on Failure {
      rethrow;
    } catch (_) {
      throw const ParseFailure('Detaliile produsului nu au putut fi citite.');
    }
  }
}
