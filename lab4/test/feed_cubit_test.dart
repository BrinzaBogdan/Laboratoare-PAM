import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_bogdan_varianta3/core/error/failures.dart';
import 'package:lab4_bogdan_varianta3/data/models/learning_feed_model.dart';
import 'package:lab4_bogdan_varianta3/domain/entities/course_details.dart';
import 'package:lab4_bogdan_varianta3/domain/entities/learning_feed.dart';
import 'package:lab4_bogdan_varianta3/domain/repositories/learning_repository.dart';
import 'package:lab4_bogdan_varianta3/domain/usecases/get_learning_feed.dart';
import 'package:lab4_bogdan_varianta3/presentation/cubit/feed_cubit.dart';
import 'package:lab4_bogdan_varianta3/presentation/cubit/feed_state.dart';

import 'helpers/fixtures.dart';

class _FakeRepository implements LearningRepository {
  _FakeRepository({this.failure});

  final Failure? failure;
  int feedCalls = 0;

  @override
  Future<LearningFeed> getLearningFeed() async {
    feedCalls++;
    if (failure != null) throw failure!;
    return LearningFeedModel.fromJson(sampleFeedJson);
  }

  @override
  Future<CourseDetails> getCourseDetails() async {
    throw UnimplementedError();
  }
}

void main() {
  group('FeedCubit', () {
    test('emite loading apoi success cu feed-ul primit', () async {
      final repository = _FakeRepository();
      final cubit = FeedCubit(getLearningFeed: GetLearningFeed(repository));
      final statuses = <FeedStatus>[];
      final subscription = cubit.stream.listen((state) {
        statuses.add(state.status);
      });

      await cubit.load();
      await Future<void>.delayed(Duration.zero);

      expect(statuses, [FeedStatus.loading, FeedStatus.success]);
      expect(cubit.state.feed, isNotNull);
      expect(cubit.state.feed!.learningPlan.items, hasLength(2));
      expect(repository.feedCalls, 1);

      await subscription.cancel();
      await cubit.close();
    });

    test('transformă eroarea de rețea în stare de failure', () async {
      final repository = _FakeRepository(
        failure: const NetworkFailure('Fără conexiune la internet.'),
      );
      final cubit = FeedCubit(getLearningFeed: GetLearningFeed(repository));

      await cubit.load();

      expect(cubit.state.status, FeedStatus.failure);
      expect(cubit.state.errorMessage, 'Fără conexiune la internet.');

      await cubit.close();
    });

    test('retry reia cererea către repository', () async {
      final repository = _FakeRepository(
        failure: const ServerFailure('Serverul a răspuns cu codul 500.'),
      );
      final cubit = FeedCubit(getLearningFeed: GetLearningFeed(repository));

      await cubit.load();
      await cubit.retry();

      expect(cubit.state.status, FeedStatus.failure);
      expect(repository.feedCalls, 2);

      await cubit.close();
    });
  });
}
