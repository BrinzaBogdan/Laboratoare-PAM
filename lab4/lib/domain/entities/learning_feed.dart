import 'package:equatable/equatable.dart';

/// Entitățile de business ale feed-ului de learning.
///
/// Nu depind de JSON, HTTP sau Flutter; sunt folosite identic de straturile
/// `data` și `presentation`.

/// Antetul paginii: salut, avatar și notificare.
class LearningHeader extends Equatable {
  const LearningHeader({
    required this.greeting,
    required this.subtitle,
    required this.avatarUrl,
    required this.hasUnread,
    required this.notificationIconUrl,
  });

  final String greeting;
  final String subtitle;
  final String avatarUrl;
  final bool hasUnread;
  final String notificationIconUrl;

  @override
  List<Object?> get props => [
        greeting,
        subtitle,
        avatarUrl,
        hasUnread,
        notificationIconUrl,
      ];
}

/// Progresul de învățare pentru ziua curentă.
class LearnedToday extends Equatable {
  const LearnedToday({
    required this.title,
    required this.learnedMinutes,
    required this.goalMinutes,
    required this.formatted,
    required this.progress,
  });

  final String title;
  final int learnedMinutes;
  final int goalMinutes;
  final String formatted;
  final double progress;

  /// Procentul afișat în UI, rotunjit la întreg.
  int get progressPercent => (progress * 100).round();

  @override
  List<Object?> get props => [
        title,
        learnedMinutes,
        goalMinutes,
        formatted,
        progress,
      ];
}

/// Antet de secțiune cu o acțiune (ex. „My courses”).
class SectionLink extends Equatable {
  const SectionLink({required this.title, required this.actionLabel});

  final String title;
  final String actionLabel;

  @override
  List<Object?> get props => [title, actionLabel];
}

/// Bannerul „What do you want to learn today?”.
class LearningPrompt extends Equatable {
  const LearningPrompt({
    required this.title,
    required this.actionLabel,
    required this.imageUrl,
  });

  final String title;
  final String actionLabel;
  final String imageUrl;

  @override
  List<Object?> get props => [title, actionLabel, imageUrl];
}

/// Un curs din planul de învățare.
class CourseSummary extends Equatable {
  const CourseSummary({
    required this.id,
    required this.title,
    required this.completed,
    required this.total,
    required this.progress,
    required this.progressIconUrl,
  });

  final String id;
  final String title;
  final int completed;
  final int total;
  final double progress;
  final String progressIconUrl;

  String get progressLabel => '$completed/$total';

  int get progressPercent => (progress * 100).round();

  @override
  List<Object?> get props => [
        id,
        title,
        completed,
        total,
        progress,
        progressIconUrl,
      ];
}

/// Secțiunea „Learning Plan”.
class LearningPlan extends Equatable {
  const LearningPlan({required this.title, required this.items});

  final String title;
  final List<CourseSummary> items;

  @override
  List<Object?> get props => [title, items];
}

/// Bannerul „Meetup”.
class Meetup extends Equatable {
  const Meetup({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  final String title;
  final String subtitle;
  final String imageUrl;

  @override
  List<Object?> get props => [title, subtitle, imageUrl];
}

/// Feed-ul complet, exact cum este livrat de serviciul Web.
class LearningFeed extends Equatable {
  const LearningFeed({
    required this.header,
    required this.learnedToday,
    required this.myCourses,
    required this.learningPrompt,
    required this.learningPlan,
    required this.meetup,
  });

  final LearningHeader header;
  final LearnedToday learnedToday;
  final SectionLink myCourses;
  final LearningPrompt learningPrompt;
  final LearningPlan learningPlan;
  final Meetup meetup;

  @override
  List<Object?> get props => [
        header,
        learnedToday,
        myCourses,
        learningPrompt,
        learningPlan,
        meetup,
      ];
}
