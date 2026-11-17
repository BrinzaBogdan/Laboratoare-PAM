import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_bogdan_varianta3/core/theme/app_theme.dart';
import 'package:lab4_bogdan_varianta3/features/learning/data/models/course_details_model.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/entities/course_details.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/entities/learning_feed.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/repositories/learning_repository.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/usecases/get_course_details.dart';
import 'package:lab4_bogdan_varianta3/features/learning/presentation/cubit/course_details_cubit.dart';
import 'package:lab4_bogdan_varianta3/features/learning/presentation/pages/course_details_page.dart';

import 'helpers/fixtures.dart';

class _FakeRepository implements LearningRepository {
  @override
  Future<LearningFeed> getLearningFeed() async {
    throw UnimplementedError();
  }

  @override
  Future<CourseDetails> getCourseDetails() async {
    return CourseDetailsModel.fromJson(withoutImages(sampleDetailsJson));
  }
}

Future<void> _pumpPage(WidgetTester tester) async {
  tester.view.physicalSize = const Size(402, 874);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    BlocProvider(
      create: (_) =>
          CourseDetailsCubit(GetCourseDetails(_FakeRepository()))..load(),
      child: MaterialApp(
        theme: buildAppTheme(),
        home: const CourseDetailsPage(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Course Overview afișează datele cursului', (tester) async {
    await _pumpPage(tester);

    expect(find.text('Course Overview'), findsOneWidget);
    expect(find.text('React Front To back'), findsOneWidget);
    expect(find.text('6h 30min'), findsOneWidget);
    expect(find.text('7 lessons'), findsOneWidget);
    expect(find.text('4.9'), findsOneWidget);
    expect(find.text('Lessons'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Introduction to React'), findsOneWidget);
    expect(find.text('Understanding React'), findsOneWidget);
    expect(find.text('Completed'), findsNothing);
    expect(find.text('Free'), findsOneWidget);
    expect(find.text('Enroll Now'), findsOneWidget);
  });

  testWidgets('tab-ul Description afișează starea goală', (tester) async {
    await _pumpPage(tester);

    await tester.tap(find.text('Description'));
    await tester.pumpAndSettle();

    expect(find.text('Descriere indisponibilă'), findsOneWidget);
    expect(find.text('Introduction to React'), findsNothing);
  });

  testWidgets('butonul Enroll afișează confirmarea', (tester) async {
    await _pumpPage(tester);

    await tester.tap(find.text('Enroll Now'));
    await tester.pump();

    expect(
      find.text('Te-ai înscris la „React Front To back”.'),
      findsOneWidget,
    );
  });
}
