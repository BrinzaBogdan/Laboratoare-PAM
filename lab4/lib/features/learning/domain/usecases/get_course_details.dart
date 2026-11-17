import '../entities/course_details.dart';
import '../repositories/learning_repository.dart';

/// Caz de utilizare: încarcă detaliile cursului.
class GetCourseDetails {
  const GetCourseDetails(this._repository);

  final LearningRepository _repository;

  Future<CourseDetails> call() => _repository.getCourseDetails();
}
