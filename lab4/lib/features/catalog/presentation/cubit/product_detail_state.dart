import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

enum ProductDetailStatus { initial, loading, success, failure }

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.status = ProductDetailStatus.initial,
    this.product,
    this.errorMessage,
  });

  final ProductDetailStatus status;
  final Product? product;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, product, errorMessage];
}
