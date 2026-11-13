import '../entities/product_page.dart';
import '../entities/product_sort.dart';
import '../repositories/product_repository.dart';

/// Caz de utilizare: încarcă o pagină din catalog.
class GetProducts {
  const GetProducts(this._repository);

  final ProductRepository _repository;

  Future<ProductPage> call({
    required int limit,
    required int skip,
    ProductSort sort = ProductSort.featured,
  }) {
    return _repository.getProducts(limit: limit, skip: skip, sort: sort);
  }
}
