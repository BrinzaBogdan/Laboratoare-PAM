import '../../domain/entities/product_review.dart';

/// Modelul JSON al unei recenzii.
///
/// Extinde entitatea din `domain`, deci poate fi folosit oriunde este
/// așteptat un `ProductReview`.
class ProductReviewModel extends ProductReview {
  const ProductReviewModel({
    required super.rating,
    required super.comment,
    required super.date,
    required super.reviewerName,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      comment: json['comment'] as String? ?? '',
      date: json['date'] as String? ?? '',
      reviewerName: json['reviewerName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'rating': rating,
        'comment': comment,
        'date': date,
        'reviewerName': reviewerName,
      };
}
