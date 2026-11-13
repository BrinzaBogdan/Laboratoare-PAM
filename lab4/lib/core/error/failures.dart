/// Erorile de business ale aplicației.
///
/// Stratul `data` prinde excepțiile tehnice (socket, timeout, JSON invalid)
/// și le transformă în `Failure`, astfel încât stratul `presentation` să nu
/// depindă de detalii de implementare.
sealed class Failure implements Exception {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

/// Nu există conexiune sau serverul nu răspunde.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Serverul a răspuns cu un cod de eroare.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Răspunsul nu a putut fi deserializat din JSON.
class ParseFailure extends Failure {
  const ParseFailure(super.message);
}

/// Orice altă eroare neprevăzută.
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
