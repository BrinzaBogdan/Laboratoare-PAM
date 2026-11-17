/// Constantele serviciului Web REST folosit de aplicație.
class ApiConstants {
  const ApiConstants._();

  static const String host = 'test-api-jlbn.onrender.com';

  /// Feed-ul de learning al variantei 4.
  static const String feedPath = '/lab2026/v4/feed';

  /// Detaliile cursului (Course Overview).
  static const String feedDetailsPath = '/lab2026/v4/feed/details';

  static const Duration timeout = Duration(seconds: 20);
}
