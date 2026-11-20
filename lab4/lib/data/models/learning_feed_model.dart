import '../../domain/entities/learning_feed.dart';

/// Modelul JSON al antetului.
class LearningHeaderModel extends LearningHeader {
  const LearningHeaderModel({
    required super.greeting,
    required super.subtitle,
    required super.avatarUrl,
    required super.hasUnread,
    required super.notificationIconUrl,
  });

  factory LearningHeaderModel.fromJson(Map<String, dynamic> json) {
    final notification = _asMap(json['notification']);

    return LearningHeaderModel(
      greeting: json['greeting'] as String? ?? 'Salut',
      subtitle: json['subtitle'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      hasUnread: notification['hasUnread'] as bool? ?? false,
      notificationIconUrl: notification['iconUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'greeting': greeting,
        'subtitle': subtitle,
        'avatarUrl': avatarUrl,
        'notification': {
          'hasUnread': hasUnread,
          'iconUrl': notificationIconUrl,
        },
      };
}

/// Modelul JSON al progresului zilei.
class LearnedTodayModel extends LearnedToday {
  const LearnedTodayModel({
    required super.title,
    required super.learnedMinutes,
    required super.goalMinutes,
    required super.formatted,
    required super.progress,
  });

  factory LearnedTodayModel.fromJson(Map<String, dynamic> json) {
    return LearnedTodayModel(
      title: json['title'] as String? ?? 'Learned today',
      learnedMinutes: _asInt(json['learnedMinutes']),
      goalMinutes: _asInt(json['goalMinutes']),
      formatted: json['formatted'] as String? ?? '',
      progress: _asDouble(json['progress']),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'learnedMinutes': learnedMinutes,
        'goalMinutes': goalMinutes,
        'formatted': formatted,
        'progress': progress,
      };
}

/// Modelul JSON al antetului de secțiune.
class SectionLinkModel extends SectionLink {
  const SectionLinkModel({
    required super.title,
    required super.actionLabel,
  });

  factory SectionLinkModel.fromJson(Map<String, dynamic> json) {
    return SectionLinkModel(
      title: json['title'] as String? ?? '',
      actionLabel: json['actionLabel'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'actionLabel': actionLabel,
      };
}

/// Modelul JSON al bannerului de prompt.
class LearningPromptModel extends LearningPrompt {
  const LearningPromptModel({
    required super.title,
    required super.actionLabel,
    required super.imageUrl,
  });

  factory LearningPromptModel.fromJson(Map<String, dynamic> json) {
    return LearningPromptModel(
      title: json['title'] as String? ?? '',
      actionLabel: json['actionLabel'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'actionLabel': actionLabel,
        'imageUrl': imageUrl,
      };
}

/// Modelul JSON al unui curs din plan.
class CourseSummaryModel extends CourseSummary {
  const CourseSummaryModel({
    required super.id,
    required super.title,
    required super.completed,
    required super.total,
    required super.progress,
    required super.progressIconUrl,
  });

  factory CourseSummaryModel.fromJson(Map<String, dynamic> json) {
    return CourseSummaryModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      completed: _asInt(json['completed']),
      total: _asInt(json['total']),
      progress: _asDouble(json['progress']),
      progressIconUrl: json['progressIconUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'completed': completed,
        'total': total,
        'progress': progress,
        'progressIconUrl': progressIconUrl,
      };
}

/// Modelul JSON al secțiunii „Learning Plan”.
class LearningPlanModel extends LearningPlan {
  const LearningPlanModel({
    required super.title,
    required super.items,
  });

  factory LearningPlanModel.fromJson(Map<String, dynamic> json) {
    final items = <CourseSummary>[];
    final rawItems = json['items'];
    if (rawItems is List) {
      for (final item in rawItems) {
        if (item is Map) {
          items.add(CourseSummaryModel.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }

    return LearningPlanModel(
      title: json['title'] as String? ?? 'Learning Plan',
      items: items,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'items': items
            .map((item) => CourseSummaryModel(
                  id: item.id,
                  title: item.title,
                  completed: item.completed,
                  total: item.total,
                  progress: item.progress,
                  progressIconUrl: item.progressIconUrl,
                ).toJson())
            .toList(),
      };
}

/// Modelul JSON al bannerului „Meetup”.
class MeetupModel extends Meetup {
  const MeetupModel({
    required super.title,
    required super.subtitle,
    required super.imageUrl,
  });

  factory MeetupModel.fromJson(Map<String, dynamic> json) {
    return MeetupModel(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'imageUrl': imageUrl,
      };
}

/// Modelul JSON al feed-ului complet.
class LearningFeedModel extends LearningFeed {
  const LearningFeedModel({
    required super.header,
    required super.learnedToday,
    required super.myCourses,
    required super.learningPrompt,
    required super.learningPlan,
    required super.meetup,
  });

  factory LearningFeedModel.fromJson(Map<String, dynamic> json) {
    return LearningFeedModel(
      header: LearningHeaderModel.fromJson(_asMap(json['header'])),
      learnedToday:
          LearnedTodayModel.fromJson(_asMap(json['learnedToday'])),
      myCourses: SectionLinkModel.fromJson(_asMap(json['myCourses'])),
      learningPrompt:
          LearningPromptModel.fromJson(_asMap(json['learningPrompt'])),
      learningPlan:
          LearningPlanModel.fromJson(_asMap(json['learningPlan'])),
      meetup: MeetupModel.fromJson(_asMap(json['meetup'])),
    );
  }

  Map<String, dynamic> toJson() => {
        'header': LearningHeaderModel(
          greeting: header.greeting,
          subtitle: header.subtitle,
          avatarUrl: header.avatarUrl,
          hasUnread: header.hasUnread,
          notificationIconUrl: header.notificationIconUrl,
        ).toJson(),
        'learnedToday': LearnedTodayModel(
          title: learnedToday.title,
          learnedMinutes: learnedToday.learnedMinutes,
          goalMinutes: learnedToday.goalMinutes,
          formatted: learnedToday.formatted,
          progress: learnedToday.progress,
        ).toJson(),
        'myCourses': SectionLinkModel(
          title: myCourses.title,
          actionLabel: myCourses.actionLabel,
        ).toJson(),
        'learningPrompt': LearningPromptModel(
          title: learningPrompt.title,
          actionLabel: learningPrompt.actionLabel,
          imageUrl: learningPrompt.imageUrl,
        ).toJson(),
        'learningPlan': LearningPlanModel(
          title: learningPlan.title,
          items: learningPlan.items,
        ).toJson(),
        'meetup': MeetupModel(
          title: meetup.title,
          subtitle: meetup.subtitle,
          imageUrl: meetup.imageUrl,
        ).toJson(),
      };
}

Map<String, dynamic> _asMap(Object? value) {
  if (value is Map) return Map<String, dynamic>.from(value);
  return const {};
}

int _asInt(Object? value) {
  if (value is num) return value.toInt();
  return 0;
}

double _asDouble(Object? value) {
  if (value is num) return value.toDouble();
  return 0;
}
