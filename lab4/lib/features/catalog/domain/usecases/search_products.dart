import '../entities/product_page.dart';
import '../repositories/product_repository.dart';

/// Caz de utilizare: caută produse după un termen introdus de utilizator.
class SearchProducts {
  const SearchProducts(this._repository);

  final ProductRepository _repository;

  Future<ProductPage> call({required String query, required int limit}) {
    return _repository.searchProducts(query: query, limit: limit);
  }
}
