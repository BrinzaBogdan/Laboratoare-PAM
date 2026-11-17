import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/course_details.dart';
import '../../domain/entities/learning_feed.dart';
import '../models/course_details_model.dart';
import '../models/learning_feed_model.dart';

/// Sursa de date remote: singurul loc care cunoaște rutele serviciului Web.
abstract class LearningRemoteDataSource {
  Future<LearningFeed> fetchLearningFeed();

  Future<CourseDetails> fetchCourseDetails();
}

class LearningRemoteDataSourceImpl implements LearningRemoteDataSource {
  LearningRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<LearningFeed> fetchLearningFeed() async {
    final json = await _client.getJson(ApiConstants.feedPath);
    return LearningFeedModel.fromJson(json);
  }

  @override
  Future<CourseDetails> fetchCourseDetails() async {
    final json = await _client.getJson(ApiConstants.feedDetailsPath);
    return CourseDetailsModel.fromJson(json);
  }
}
