import '../entities/course_details.dart';
import '../entities/learning_feed.dart';

/// Contractul de acces la date, cunoscut de stratul `domain`.
///
/// Prezentarea depinde doar de această abstractizare, nu de HTTP sau JSON.
abstract class LearningRepository {
  Future<LearningFeed> getLearningFeed();

  Future<CourseDetails> getCourseDetails();
}
