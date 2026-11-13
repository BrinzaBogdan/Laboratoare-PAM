/// Constantele serviciului Web REST folosit de aplicație.
class ApiConstants {
  const ApiConstants._();

  static const String host = 'dummyjson.com';

  /// Categoria de produse afișată în catalog.
  static const String category = 'sports-accessories';

  /// Numărul de produse cerute pe pagină.
  static const int pageSize = 12;

  static const Duration timeout = Duration(seconds: 15);
}
