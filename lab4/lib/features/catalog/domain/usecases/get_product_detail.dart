import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Caz de utilizare: încarcă detaliile complete ale unui produs.
class GetProductDetail {
  const GetProductDetail(this._repository);

  final ProductRepository _repository;

  Future<Product> call(int id) => _repository.getProductById(id);
}
