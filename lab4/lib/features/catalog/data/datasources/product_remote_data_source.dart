import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_page.dart';
import '../../domain/entities/product_sort.dart';
import '../models/product_model.dart';
import '../models/product_page_model.dart';

/// Sursa de date remote: singurul loc care cunoaște rutele serviciului Web.
abstract class ProductRemoteDataSource {
  Future<ProductPage> fetchProducts({
    required int limit,
    required int skip,
    required ProductSort sort,
  });

  Future<ProductPage> searchProducts({
    required String query,
    required int limit,
  });

  Future<Product> fetchProductById(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<ProductPage> fetchProducts({
    required int limit,
    required int skip,
    required ProductSort sort,
  }) async {
    final query = <String, String>{
      'limit': '$limit',
      'skip': '$skip',
    };
    if (sort.sortBy != null) {
      query['sortBy'] = sort.sortBy!;
      query['order'] = sort.order!;
    }

    final json = await _client.getJson(
      '/products/category/${ApiConstants.category}',
      query: query,
    );
    return ProductPageModel.fromJson(json);
  }

  @override
  Future<ProductPage> searchProducts({
    required String query,
    required int limit,
  }) async {
    final json = await _client.getJson(
      '/products/search',
      query: {'q': query, 'limit': '$limit'},
    );

    // Endpoint-ul de căutare nu permite filtrarea pe categorie, așa că
    // păstrăm doar produsele din categoria magazinului.
    final page = ProductPageModel.fromJson(json);
    final items = page.items
        .where((product) => product.category == ApiConstants.category)
        .toList();

    return ProductPage(
      items: items,
      total: items.length,
      skip: 0,
      limit: limit,
    );
  }

  @override
  Future<Product> fetchProductById(int id) async {
    final json = await _client.getJson('/products/$id');
    return ProductModel.fromJson(json);
  }
}
