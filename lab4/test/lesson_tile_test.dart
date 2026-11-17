import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_bogdan_varianta3/features/learning/domain/entities/course_details.dart';
import 'package:lab4_bogdan_varianta3/features/learning/presentation/widgets/lesson_tile.dart';

Lesson _lesson({
  String title = 'Introduction to React',
  bool completed = false,
  bool locked = false,
}) {
  return Lesson(
    id: 'lesson-1',
    title: title,
    duration: '04:28',
    durationSeconds: 268,
    completed: completed,
    locked: locked,
    // URL-uri goale => componenta afișează iconițele fallback, fără rețea.
    playIconUrl: '',
    arrowIconUrl: '',
  );
}

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: Padding(padding: const EdgeInsets.all(16), child: child),
    ),
  );
}

void main() {
  group('LessonTile', () {
    testWidgets('afișează titlul și durata lecției', (tester) async {
      await tester.pumpWidget(
        _wrap(LessonTile(lesson: _lesson(), onTap: () {})),
      );

      expect(find.text('Introduction to React'), findsOneWidget);
      expect(find.text('04:28'), findsOneWidget);
      expect(find.text('Completed'), findsNothing);
      expect(find.byIcon(Icons.lock_outline_rounded), findsNothing);
    });

    testWidgets('marchează lecția finalizată', (tester) async {
      await tester.pumpWidget(
        _wrap(LessonTile(lesson: _lesson(completed: true), onTap: () {})),
      );

      expect(find.text('Completed'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    });

    testWidgets('lecția blocată afișează lacătul și nu răspunde la tap',
        (tester) async {
      var taps = 0;

      await tester.pumpWidget(
        _wrap(
          LessonTile(
            lesson: _lesson(locked: true),
            onTap: () => taps++,
          ),
        ),
      );

      expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);

      await tester.tap(find.byType(LessonTile));
      await tester.pump();

      expect(taps, 0);
    });

    testWidgets('lecția deblocată apelează callback-ul la tap',
        (tester) async {
      var taps = 0;

      await tester.pumpWidget(
        _wrap(
          LessonTile(
            lesson: _lesson(),
            onTap: () => taps++,
          ),
        ),
      );

      await tester.tap(find.byType(LessonTile));
      await tester.pump();

      expect(taps, 1);
    });
  });
}
