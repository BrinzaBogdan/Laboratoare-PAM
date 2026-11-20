import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/state_views.dart';
import '../../domain/entities/learning_feed.dart';
import '../../domain/usecases/get_course_details.dart';
import '../cubit/course_details_cubit.dart';
import '../cubit/feed_cubit.dart';
import '../cubit/feed_state.dart';
import '../widgets/course_progress_tile.dart';
import '../widgets/greeting_header.dart';
import '../widgets/learned_today_card.dart';
import '../widgets/learning_plan_summary.dart';
import '../widgets/learning_prompt_card.dart';
import '../widgets/meetup_banner.dart';
import '../widgets/my_courses_sheet.dart';
import '../widgets/section_header.dart';
import 'course_details_page.dart';

/// Ecranul principal: feed-ul de learning.
class FeedPage extends StatelessWidget {
  const FeedPage({super.key, required this.getCourseDetails});

  final GetCourseDetails getCourseDetails;

  void _openCourse(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
          create: (_) => CourseDetailsCubit(getCourseDetails)..load(),
          child: const CourseDetailsPage(),
        ),
      ),
    );
  }

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
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<FeedCubit, FeedState>(
          builder: (context, state) {
            if (state.status == FeedStatus.initial ||
                state.status == FeedStatus.loading) {
              return const LoadingView(message: 'Se încarcă feed-ul...');
            }

            if (state.status == FeedStatus.failure) {
              return ErrorView(
                message: state.errorMessage ?? 'Feed-ul nu a putut fi încărcat.',
                onRetry: context.read<FeedCubit>().retry,
              );
            }

            final feed = state.feed;
            if (feed == null) {
              return EmptyView(
                title: 'Feed indisponibil',
                message: 'Nu există date de afișat momentan.',
                onAction: context.read<FeedCubit>().retry,
              );
            }

            return RefreshIndicator(
              color: kAccent,
              onRefresh: context.read<FeedCubit>().refresh,
              child: _FeedContent(
                feed: feed,
                onOpenCourse: () => _openCourse(context),
                onShowMessage: (message) => _showMessage(context, message),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FeedContent extends StatelessWidget {
  const _FeedContent({
    required this.feed,
    required this.onOpenCourse,
    required this.onShowMessage,
  });

  final LearningFeed feed;
  final VoidCallback onOpenCourse;
  final ValueChanged<String> onShowMessage;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
      children: [
        GreetingHeader(
          header: feed.header,
          onNotificationTap: () => onShowMessage(
            feed.header.hasUnread
                ? 'Ai notificări noi.'
                : 'Nu ai notificări noi.',
          ),
        ),
        const SizedBox(height: 18),
        LearnedTodayCard(data: feed.learnedToday),
        const SizedBox(height: 22),
        SectionHeader(
          title: feed.myCourses.title,
          actionLabel: feed.myCourses.actionLabel,
          onAction: () => showMyCoursesSheet(
            context,
            title: feed.myCourses.title,
            courses: feed.learningPlan.items,
            onOpen: (_) => onOpenCourse(),
          ),
        ),
        const SizedBox(height: 10),
        for (final course in feed.learningPlan.items) ...[
          CourseProgressTile(
            course: course,
            onTap: onOpenCourse,
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 8),
        LearningPromptCard(
          prompt: feed.learningPrompt,
          onStart: onOpenCourse,
        ),
        const SizedBox(height: 22),
        SectionHeader(title: feed.learningPlan.title),
        const SizedBox(height: 10),
        LearningPlanSummary(plan: feed.learningPlan),
        const SizedBox(height: 22),
        MeetupBanner(
          meetup: feed.meetup,
          onTap: () => onShowMessage(
            'Meetup-urile vor fi disponibile în curând.',
          ),
        ),
      ],
    );
  }
}
