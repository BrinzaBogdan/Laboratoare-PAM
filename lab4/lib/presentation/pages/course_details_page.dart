import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/remote_svg_icon.dart';
import '../../../../core/widgets/state_views.dart';
import '../../domain/entities/course_details.dart';
import '../cubit/course_details_cubit.dart';
import '../cubit/course_details_state.dart';
import '../widgets/course_hero_card.dart';
import '../widgets/course_meta_row.dart';
import '../widgets/course_tabs_bar.dart';
import '../widgets/enroll_bar.dart';
import '../widgets/lesson_tile.dart';

/// Ecranul „Course Overview”, alimentat asincron de la serviciul Web.
class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: kInk,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: (context, state) {
        final details = state.details;

        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _DetailsHeader(
                  title: details?.navigation.title ?? 'Course Overview',
                  backIconUrl: details?.navigation.backIconUrl ?? '',
                  onBack: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: switch (state.status) {
                    CourseDetailsStatus.initial ||
                    CourseDetailsStatus.loading =>
                      const LoadingView(message: 'Se încarcă cursul...'),
                    CourseDetailsStatus.failure => ErrorView(
                        message: state.errorMessage ??
                            'Cursul nu a putut fi încărcat.',
                        onRetry: context.read<CourseDetailsCubit>().load,
                      ),
                    CourseDetailsStatus.success => details == null
                        ? const EmptyView(
                            title: 'Curs indisponibil',
                            message: 'Detaliile cursului lipsesc.',
                          )
                        : _CourseContent(
                            details: details,
                            selectedTabId: state.selectedTabId,
                            onSelectTab:
                                context.read<CourseDetailsCubit>().selectTab,
                            onShowMessage: (message) =>
                                _showMessage(context, message),
                          ),
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: details == null
              ? null
              : EnrollBar(
                  actions: details.actions,
                  onEnroll: () => _showMessage(
                    context,
                    'Te-ai înscris la „${details.course.title}”.',
                  ),
                ),
        );
      },
    );
  }
}

class _DetailsHeader extends StatelessWidget {
  const _DetailsHeader({
    required this.title,
    required this.backIconUrl,
    required this.onBack,
  });

  final String title;
  final String backIconUrl;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 10),
      child: Row(
        children: [
          Material(
            color: kCard,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onBack,
              child: SizedBox(
                width: 42,
                height: 42,
                child: Center(
                  child: RemoteSvgIcon(
                    url: backIconUrl,
                    size: 19,
                    fallbackIcon: Icons.arrow_back_rounded,
                    fallbackColor: kInk,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: kInk,
              ),
            ),
          ),
          const SizedBox(width: 42),
        ],
      ),
    );
  }
}

class _CourseContent extends StatelessWidget {
  const _CourseContent({
    required this.details,
    required this.selectedTabId,
    required this.onSelectTab,
    required this.onShowMessage,
  });

  final CourseDetails details;
  final String selectedTabId;
  final ValueChanged<String> onSelectTab;
  final ValueChanged<String> onShowMessage;

  @override
  Widget build(BuildContext context) {
    final course = details.course;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: CourseHeroCard(
              hero: course.hero,
              onPlay: () => onShowMessage('Videoclipul va porni în curând.'),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            course.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: kInk,
              height: 1.2,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 12),
          CourseMetaRow(course: course, icons: details.uiIcons),
          const SizedBox(height: 18),
          CourseTabsBar(
            tabs: course.tabs,
            selectedId: selectedTabId,
            onSelected: onSelectTab,
          ),
          const SizedBox(height: 14),
          if (selectedTabId == 'lessons')
            _LessonsList(
              lessons: course.lessons,
              onOpenLesson: (lesson) => onShowMessage(
                lesson.completed
                    ? 'Ai finalizat deja lecția „${lesson.title}”.'
                    : 'Lecția „${lesson.title}” va fi disponibilă în curând.',
              ),
            )
          else if (course.description.isEmpty)
            const EmptyView(
              title: 'Descriere indisponibilă',
              message: 'Cursul nu are încă o descriere.',
              icon: Icons.notes_rounded,
            )
          else
            Text(
              course.description.text,
              style: const TextStyle(
                fontSize: 13.5,
                color: kInkSoft,
                height: 1.65,
              ),
            ),
        ],
      ),
    );
  }
}

class _LessonsList extends StatelessWidget {
  const _LessonsList({
    required this.lessons,
    required this.onOpenLesson,
  });

  final List<Lesson> lessons;
  final ValueChanged<Lesson> onOpenLesson;

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return const EmptyView(
        title: 'Nicio lecție',
        message: 'Cursul nu are lecții disponibile momentan.',
        icon: Icons.playlist_remove_rounded,
      );
    }

    return Column(
      children: [
        for (final lesson in lessons) ...[
          LessonTile(
            lesson: lesson,
            onTap: () => onOpenLesson(lesson),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
