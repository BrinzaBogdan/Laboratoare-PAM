/// Opțiunile de sortare expuse utilizatorului.
///
/// `sortBy` și `order` sunt parametrii trimiși către serviciul Web, deci
/// sortarea este făcută pe server, nu în interfață.
enum ProductSort {
  featured('Recomandate', null, null),
  priceAsc('Preț crescător', 'price', 'asc'),
  priceDesc('Preț descrescător', 'price', 'desc'),
  ratingDesc('Cele mai apreciate', 'rating', 'desc'),
  titleAsc('Nume A-Z', 'title', 'asc');

  const ProductSort(this.label, this.sortBy, this.order);

  final String label;
  final String? sortBy;
  final String? order;
}
