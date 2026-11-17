import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_bogdan_varianta3/core/error/failures.dart';
import 'package:lab4_bogdan_varianta3/features/learning/data/models/course_details_model.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/entities/course_details.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/entities/learning_feed.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/repositories/learning_repository.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/usecases/get_course_details.dart';
import 'package:lab4_bogdan_varianta3/features/learning/presentation/cubit/course_details_cubit.dart';
import 'package:lab4_bogdan_varianta3/features/learning/presentation/cubit/course_details_state.dart';

import 'helpers/fixtures.dart';

class _FakeRepository implements LearningRepository {
  _FakeRepository({this.failure});

  final Failure? failure;
  int detailsCalls = 0;

  @override
  Future<LearningFeed> getLearningFeed() async {
    throw UnimplementedError();
  }

  @override
  Future<CourseDetails> getCourseDetails() async {
    detailsCalls++;
    if (failure != null) throw failure!;
    return CourseDetailsModel.fromJson(sampleDetailsJson);
  }
}

void main() {
  group('CourseDetailsCubit', () {
    test('încarcă detaliile și pornește pe tab-ul Lessons', () async {
      final repository = _FakeRepository();
      final cubit = CourseDetailsCubit(GetCourseDetails(repository));

      await cubit.load();

      expect(cubit.state.status, CourseDetailsStatus.success);
      expect(cubit.state.details, isNotNull);
      expect(cubit.state.details!.course.title, 'React Front To back');
      expect(cubit.state.details!.course.lessons, hasLength(4));
      expect(cubit.state.selectedTabId, 'lessons');
      expect(repository.detailsCalls, 1);

      await cubit.close();
    });

    test('schimbă tab-ul selectat', () async {
      final cubit = CourseDetailsCubit(GetCourseDetails(_FakeRepository()));
      await cubit.load();

      cubit.selectTab('description');

      expect(cubit.state.selectedTabId, 'description');

      await cubit.close();
    });

    test('transformă eroarea în stare de failure', () async {
      final cubit = CourseDetailsCubit(
        GetCourseDetails(
          _FakeRepository(failure: const ParseFailure('JSON invalid.')),
        ),
      );

      await cubit.load();

      expect(cubit.state.status, CourseDetailsStatus.failure);
      expect(cubit.state.errorMessage, 'JSON invalid.');
      expect(cubit.state.details, isNull);

      await cubit.close();
    });
  });
}
