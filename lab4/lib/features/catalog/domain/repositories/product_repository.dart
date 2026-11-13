import '../entities/product.dart';
import '../entities/product_page.dart';
import '../entities/product_sort.dart';

/// Contractul de acces la date, cunoscut de stratul `domain`.
///
/// Stratul `data` îl implementează, iar `presentation` depinde doar de
/// această abstracție, niciodată de HTTP sau de JSON.
abstract class ProductRepository {
  Future<ProductPage> getProducts({
    required int limit,
    required int skip,
    required ProductSort sort,
  });

  Future<ProductPage> searchProducts({
    required String query,
    required int limit,
  });

  Future<Product> getProductById(int id);
}
