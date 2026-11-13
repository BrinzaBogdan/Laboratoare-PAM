import 'package:equatable/equatable.dart';

import 'product.dart';

/// O pagină de produse, exact așa cum este descrisă de serviciul Web.
///
/// `skip` și `total` sunt păstrate pentru a putea calcula dacă mai există
/// elemente de încărcat la scroll.
class ProductPage extends Equatable {
  const ProductPage({
    required this.items,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<Product> items;
  final int total;
  final int skip;
  final int limit;

  bool get hasMore => skip + items.length < total;

  @override
  List<Object?> get props => [items, total, skip, limit];
}
