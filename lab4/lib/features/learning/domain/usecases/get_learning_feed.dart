import '../entities/learning_feed.dart';
import '../repositories/learning_repository.dart';

/// Caz de utilizare: încarcă feed-ul de learning.
class GetLearningFeed {
  const GetLearningFeed(this._repository);

  final LearningRepository _repository;

  Future<LearningFeed> call() => _repository.getLearningFeed();
}
