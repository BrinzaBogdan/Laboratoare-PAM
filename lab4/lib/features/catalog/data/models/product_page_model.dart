import '../../domain/entities/product_page.dart';
import 'product_model.dart';

/// Modelul JSON al unei pagini de produse.
class ProductPageModel extends ProductPage {
  const ProductPageModel({
    required super.items,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory ProductPageModel.fromJson(Map<String, dynamic> json) {
    final items = <ProductModel>[];
    final rawProducts = json['products'];
    if (rawProducts is List) {
      for (final item in rawProducts) {
        if (item is Map) {
          items.add(ProductModel.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }

    return ProductPageModel(
      items: items,
      total: (json['total'] as num?)?.toInt() ?? items.length,
      skip: (json['skip'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? items.length,
    );
  }

  Map<String, dynamic> toJson() => {
        'products': items
            .map((product) => ProductModel.fromEntity(product).toJson())
            .toList(),
        'total': total,
        'skip': skip,
        'limit': limit,
      };
}
