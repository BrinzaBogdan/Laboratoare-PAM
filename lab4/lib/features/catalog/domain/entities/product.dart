import 'package:equatable/equatable.dart';

import 'product_review.dart';

/// Entitatea de business a unui produs din catalog.
///
/// Nu conține nicio dependență de JSON, HTTP sau Flutter: este folosită
/// identic de stratul `data` și de stratul `presentation`.
class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.images,
    required this.reviews,
    required this.thumbnail,
    required this.sku,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.returnPolicy,
    required this.availabilityStatus,
    required this.minimumOrderQuantity,
    this.brand,
    this.weight,
  });

  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final List<String> images;
  final List<ProductReview> reviews;
  final String thumbnail;
  final String sku;
  final String warrantyInformation;
  final String shippingInformation;
  final String returnPolicy;
  final String availabilityStatus;
  final int minimumOrderQuantity;
  final String? brand;
  final double? weight;

  bool get hasDiscount => discountPercentage > 0;

  bool get inStock => stock > 0;

  /// Prețul final, după aplicarea reducerii primite de la server.
  double get finalPrice => price * (1 - discountPercentage / 100);

  /// Prima imagine disponibilă, cu fallback pe thumbnail.
  String get coverImage =>
      images.isNotEmpty ? images.first : thumbnail;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        price,
        discountPercentage,
        rating,
        stock,
        tags,
        images,
        reviews,
        thumbnail,
        sku,
        warrantyInformation,
        shippingInformation,
        returnPolicy,
        availabilityStatus,
        minimumOrderQuantity,
        brand,
        weight,
      ];
}
