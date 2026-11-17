import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_bogdan_varianta3/core/theme/app_theme.dart';
import 'package:lab4_bogdan_varianta3/features/learning/data/models/course_details_model.dart';
import 'package:lab4_bogdan_varianta3/features/learning/data/models/learning_feed_model.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/entities/course_details.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/entities/learning_feed.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/repositories/learning_repository.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/usecases/get_course_details.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/usecases/get_learning_feed.dart';
import 'package:lab4_bogdan_varianta3/features/learning/presentation/cubit/feed_cubit.dart';
import 'package:lab4_bogdan_varianta3/features/learning/presentation/pages/feed_page.dart';

import 'helpers/fixtures.dart';

class _FakeRepository implements LearningRepository {
  @override
  Future<LearningFeed> getLearningFeed() async {
    return LearningFeedModel.fromJson(withoutImages(sampleFeedJson));
  }

  @override
  Future<CourseDetails> getCourseDetails() async {
    return CourseDetailsModel.fromJson(withoutImages(sampleDetailsJson));
  }
}

void main() {
  testWidgets('feed-ul afișează toate secțiunile primite de la API',
      (tester) async {
    tester.view.physicalSize = const Size(402, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final repository = _FakeRepository();

    await tester.pumpWidget(
      BlocProvider(
        create: (_) =>
            FeedCubit(getLearningFeed: GetLearningFeed(repository))..load(),
        child: MaterialApp(
          theme: buildAppTheme(),
          home: FeedPage(getCourseDetails: GetCourseDetails(repository)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Hi, Kristin'), findsOneWidget);
    expect(find.text('46min / 60min'), findsOneWidget);
    expect(find.text('My courses'), findsNWidgets(2));
    expect(find.text('Packaging Design'), findsOneWidget);
    expect(find.text('Product Design'), findsOneWidget);
    expect(find.text('What do you want to learn today?'), findsOneWidget);
    expect(find.text('2 courses in progress'), findsOneWidget);
    expect(find.text('46/72 lessons completed'), findsOneWidget);
    expect(find.text('Meetup'), findsOneWidget);
    expect(
      find.text('Off-line exchange of learning experience'),
      findsOneWidget,
    );
  });

  testWidgets('tap pe un curs deschide Course Overview', (tester) async {
    tester.view.physicalSize = const Size(402, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final repository = _FakeRepository();

    await tester.pumpWidget(
      BlocProvider(
        create: (_) =>
            FeedCubit(getLearningFeed: GetLearningFeed(repository))..load(),
        child: MaterialApp(
          theme: buildAppTheme(),
          home: FeedPage(getCourseDetails: GetCourseDetails(repository)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Packaging Design'));
    await tester.pumpAndSettle();

    expect(find.text('Course Overview'), findsOneWidget);
    expect(find.text('React Front To back'), findsOneWidget);
    expect(find.text('6h 30min'), findsOneWidget);
    expect(find.text('Enroll Now'), findsOneWidget);
  });
}
