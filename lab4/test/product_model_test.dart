import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_bogdan_varianta3/features/catalog/data/models/product_model.dart';

void main() {
  const sampleJson = <String, dynamic>{
    'id': 137,
    'title': 'American Football',
    'description': 'A classic ball used in American football games.',
    'category': 'sports-accessories',
    'price': 19.99,
    'discountPercentage': 4.93,
    'rating': 4.91,
    'stock': 53,
    'tags': ['sports equipment', 'american football'],
    'sku': 'SPO-BRD-AME-137',
    'weight': 2,
    'warrantyInformation': '6 months warranty',
    'shippingInformation': 'Ships in 1 month',
    'availabilityStatus': 'In Stock',
    'minimumOrderQuantity': 1,
    'thumbnail': 'https://cdn.dummyjson.com/thumb.png',
    'images': [
      'https://cdn.dummyjson.com/1.png',
      'https://cdn.dummyjson.com/2.png',
    ],
    'reviews': [
      {
        'rating': 4,
        'comment': 'Awesome product!',
        'date': '2025-04-30T09:41:02.054Z',
        'reviewerName': 'Scarlett Bowman',
      },
    ],
  };

  group('ProductModel', () {
    test('deserializează corect răspunsul JSON', () {
      final product = ProductModel.fromJson(sampleJson);

      expect(product.id, 137);
      expect(product.title, 'American Football');
      expect(product.category, 'sports-accessories');
      expect(product.price, 19.99);
      expect(product.rating, 4.91);
      expect(product.stock, 53);
      expect(product.tags, hasLength(2));
      expect(product.images, hasLength(2));
      expect(product.coverImage, 'https://cdn.dummyjson.com/1.png');
      expect(product.reviews, hasLength(1));
      expect(product.reviews.first.reviewerName, 'Scarlett Bowman');
      expect(product.reviews.first.shortDate, '2025-04-30');
    });

    test('calculează prețul final cu reducere', () {
      final product = ProductModel.fromJson(sampleJson);

      expect(product.hasDiscount, isTrue);
      expect(product.finalPrice, closeTo(19.004493, 0.000001));
    });

    test('serializează produsul înapoi în JSON', () {
      final product = ProductModel.fromJson(sampleJson);
      final json = product.toJson();

      expect(json['id'], 137);
      expect(json['title'], 'American Football');
      expect(json['price'], 19.99);
      expect(json['reviews'], hasLength(1));
      expect(
        (json['reviews'] as List).first,
        containsPair('reviewerName', 'Scarlett Bowman'),
      );
    });

    test('acceptă valori lipsă fără să arunce excepții', () {
      final product = ProductModel.fromJson(const {'id': 1});

      expect(product.id, 1);
      expect(product.title, 'Produs fără nume');
      expect(product.price, 0);
      expect(product.images, isEmpty);
      expect(product.reviews, isEmpty);
      expect(product.hasDiscount, isFalse);
    });
  });
}
