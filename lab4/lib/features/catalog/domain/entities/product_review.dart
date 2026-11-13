import 'package:equatable/equatable.dart';

/// O recenzie primită de la serviciul Web.
class ProductReview extends Equatable {
  const ProductReview({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
  });

  final int rating;
  final String comment;
  final String date;
  final String reviewerName;

  /// Data într-un format scurt, folosit direct în interfață.
  String get shortDate => date.length >= 10 ? date.substring(0, 10) : date;

  @override
  List<Object?> get props => [rating, comment, date, reviewerName];
}
