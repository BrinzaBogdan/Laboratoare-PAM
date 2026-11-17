import '../../../../core/error/failures.dart';
import '../../domain/entities/course_details.dart';
import '../../domain/entities/learning_feed.dart';
import '../../domain/repositories/learning_repository.dart';
import '../datasources/learning_remote_data_source.dart';

/// Implementarea contractului din `domain`.
///
/// Traduce orice eroare neașteptată (inclusiv JSON invalid) într-un `Failure`,
/// ca prezentarea să primească doar erori de business.
class LearningRepositoryImpl implements LearningRepository {
  LearningRepositoryImpl(this._remoteDataSource);

  final LearningRemoteDataSource _remoteDataSource;

  @override
  Future<LearningFeed> getLearningFeed() async {
    try {
      return await _remoteDataSource.fetchLearningFeed();
    } on Failure {
      rethrow;
    } catch (_) {
      throw const ParseFailure('Feed-ul primit nu a putut fi citit.');
    }
  }

  @override
  Future<CourseDetails> getCourseDetails() async {
    try {
      return await _remoteDataSource.fetchCourseDetails();
    } on Failure {
      rethrow;
    } catch (_) {
      throw const ParseFailure('Detaliile cursului nu au putut fi citite.');
    }
  }
}
