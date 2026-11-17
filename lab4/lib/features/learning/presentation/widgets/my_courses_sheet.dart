import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/learning_feed.dart';
import 'course_progress_tile.dart';

/// Deschide lista cursurilor din „My courses”.
Future<void> showMyCoursesSheet(
  BuildContext context, {
  required String title,
  required List<CourseSummary> courses,
  required ValueChanged<CourseSummary> onOpen,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: kCard,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: kFieldFill,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: kInk,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${courses.length} courses',
                    style: const TextStyle(fontSize: 12, color: kMuted),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              if (courses.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 28),
                  child: Text(
                    'Nu există cursuri în planul tău.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: kMuted),
                  ),
                )
              else
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: courses.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return CourseProgressTile(
                        course: course,
                        onTap: () {
                          Navigator.of(sheetContext).pop();
                          onOpen(course);
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}
