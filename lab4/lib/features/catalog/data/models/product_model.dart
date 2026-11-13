import '../../domain/entities/product.dart';
import '../../domain/entities/product_review.dart';
import 'product_review_model.dart';

/// Modelul JSON al unui produs.
///
/// Aici are loc deserializarea (`fromJson`) și serializarea (`toJson`).
/// Restul aplicației lucrează cu entitatea `Product`, fără să știe de JSON.
class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.tags,
    required super.images,
    required super.reviews,
    required super.thumbnail,
    required super.sku,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.returnPolicy,
    required super.availabilityStatus,
    required super.minimumOrderQuantity,
    super.brand,
    super.weight,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final images = <String>[];
    final rawImages = json['images'];
    if (rawImages is List) {
      for (final item in rawImages) {
        if (item is String) images.add(item);
      }
    }

    final tags = <String>[];
    final rawTags = json['tags'];
    if (rawTags is List) {
      for (final item in rawTags) {
        if (item is String) tags.add(item);
      }
    }

    final reviews = <ProductReview>[];
    final rawReviews = json['reviews'];
    if (rawReviews is List) {
      for (final item in rawReviews) {
        if (item is Map) {
          reviews.add(
            ProductReviewModel.fromJson(Map<String, dynamic>.from(item)),
          );
        }
      }
    }

    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? 'Produs fără nume',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      tags: tags,
      images: images,
      reviews: reviews,
      thumbnail: json['thumbnail'] as String? ??
          (images.isNotEmpty ? images.first : ''),
      sku: json['sku'] as String? ?? '',
      warrantyInformation: json['warrantyInformation'] as String? ?? '',
      shippingInformation: json['shippingInformation'] as String? ?? '',
      returnPolicy: json['returnPolicy'] as String? ?? '',
      availabilityStatus: json['availabilityStatus'] as String? ?? '',
      minimumOrderQuantity:
          (json['minimumOrderQuantity'] as num?)?.toInt() ?? 1,
      brand: json['brand'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
    );
  }

  /// Reconstruiește modelul dintr-o entitate (folosit la serializare).
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      category: product.category,
      price: product.price,
      discountPercentage: product.discountPercentage,
      rating: product.rating,
      stock: product.stock,
      tags: product.tags,
      images: product.images,
      reviews: product.reviews,
      thumbnail: product.thumbnail,
      sku: product.sku,
      warrantyInformation: product.warrantyInformation,
      shippingInformation: product.shippingInformation,
      returnPolicy: product.returnPolicy,
      availabilityStatus: product.availabilityStatus,
      minimumOrderQuantity: product.minimumOrderQuantity,
      brand: product.brand,
      weight: product.weight,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'tags': tags,
        'images': images,
        'reviews': reviews
            .map(
              (review) => review is ProductReviewModel
                  ? review.toJson()
                  : ProductReviewModel(
                      rating: review.rating,
                      comment: review.comment,
                      date: review.date,
                      reviewerName: review.reviewerName,
                    ).toJson(),
            )
            .toList(),
        'thumbnail': thumbnail,
        'sku': sku,
        'warrantyInformation': warrantyInformation,
        'shippingInformation': shippingInformation,
        'returnPolicy': returnPolicy,
        'availabilityStatus': availabilityStatus,
        'minimumOrderQuantity': minimumOrderQuantity,
        'brand': brand,
        'weight': weight,
      };
}
