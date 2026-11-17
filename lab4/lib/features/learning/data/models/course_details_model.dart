import '../../domain/entities/course_details.dart';

/// Modelul JSON al navigării ecranului de detalii.
class DetailsNavigationModel extends DetailsNavigation {
  const DetailsNavigationModel({
    required super.title,
    required super.backIconUrl,
  });

  factory DetailsNavigationModel.fromJson(Map<String, dynamic> json) {
    return DetailsNavigationModel(
      title: json['title'] as String? ?? 'Course Overview',
      backIconUrl: json['backIconUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'backIconUrl': backIconUrl,
      };
}

/// Modelul JSON al hero-ului cursului.
class CourseHeroModel extends CourseHero {
  const CourseHeroModel({
    required super.label,
    required super.imageUrl,
    required super.playIconUrl,
    required super.videoCount,
    required super.classCount,
  });

  factory CourseHeroModel.fromJson(Map<String, dynamic> json) {
    return CourseHeroModel(
      label: json['label'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      playIconUrl: json['playIconUrl'] as String? ?? '',
      videoCount: _asInt(json['videoCount']),
      classCount: _asInt(json['classCount']),
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'imageUrl': imageUrl,
        'playIconUrl': playIconUrl,
        'videoCount': videoCount,
        'classCount': classCount,
      };
}

/// Modelul JSON al unui tab.
class CourseTabModel extends CourseTab {
  const CourseTabModel({
    required super.id,
    required super.label,
    required super.selected,
  });

  factory CourseTabModel.fromJson(Map<String, dynamic> json) {
    return CourseTabModel(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      selected: json['selected'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'selected': selected,
      };
}

/// Modelul JSON al colecției de tab-uri.
class CourseTabsModel extends CourseTabs {
  const CourseTabsModel({
    required super.selected,
    required super.items,
  });

  factory CourseTabsModel.fromJson(Map<String, dynamic> json) {
    final items = <CourseTab>[];
    final rawItems = json['items'];
    if (rawItems is List) {
      for (final item in rawItems) {
        if (item is Map) {
          items.add(CourseTabModel.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }

    final selected = json['selected'] as String?;
    return CourseTabsModel(
      selected: selected ??
          (items.isNotEmpty ? items.first.id : 'lessons'),
      items: items,
    );
  }

  Map<String, dynamic> toJson() => {
        'selected': selected,
        'items': items
            .map((item) => CourseTabModel(
                  id: item.id,
                  label: item.label,
                  selected: item.selected,
                ).toJson())
            .toList(),
      };
}

/// Modelul JSON al unei lecții.
class LessonModel extends Lesson {
  const LessonModel({
    required super.id,
    required super.title,
    required super.duration,
    required super.durationSeconds,
    required super.completed,
    required super.locked,
    required super.playIconUrl,
    required super.arrowIconUrl,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      durationSeconds: _asInt(json['durationSeconds']),
      completed: json['completed'] as bool? ?? false,
      locked: json['locked'] as bool? ?? false,
      playIconUrl: json['playIconUrl'] as String? ?? '',
      arrowIconUrl: json['arrowIconUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'duration': duration,
        'durationSeconds': durationSeconds,
        'completed': completed,
        'locked': locked,
        'playIconUrl': playIconUrl,
        'arrowIconUrl': arrowIconUrl,
      };
}

/// Modelul JSON al descrierii.
class CourseDescriptionModel extends CourseDescription {
  const CourseDescriptionModel({required super.text});

  factory CourseDescriptionModel.fromJson(Map<String, dynamic> json) {
    return CourseDescriptionModel(text: json['text'] as String? ?? '');
  }

  Map<String, dynamic> toJson() => {'text': text};
}

/// Modelul JSON al cursului.
class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.title,
    required super.duration,
    required super.durationMinutes,
    required super.lessonCount,
    required super.rating,
    required super.hero,
    required super.tabs,
    required super.lessons,
    required super.description,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    final lessons = <Lesson>[];
    final rawLessons = json['lessons'];
    if (rawLessons is List) {
      for (final item in rawLessons) {
        if (item is Map) {
          lessons.add(LessonModel.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }

    return CourseModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      durationMinutes: _asInt(json['durationMinutes']),
      lessonCount: _asInt(json['lessonCount']),
      rating: _asDouble(json['rating']),
      hero: CourseHeroModel.fromJson(_asMap(json['hero'])),
      tabs: CourseTabsModel.fromJson(_asMap(json['tabs'])),
      lessons: lessons,
      description:
          CourseDescriptionModel.fromJson(_asMap(json['description'])),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'duration': duration,
        'durationMinutes': durationMinutes,
        'lessonCount': lessonCount,
        'rating': rating,
        'hero': CourseHeroModel(
          label: hero.label,
          imageUrl: hero.imageUrl,
          playIconUrl: hero.playIconUrl,
          videoCount: hero.videoCount,
          classCount: hero.classCount,
        ).toJson(),
        'tabs': CourseTabsModel(
          selected: tabs.selected,
          items: tabs.items,
        ).toJson(),
        'lessons': lessons
            .map((lesson) => LessonModel(
                  id: lesson.id,
                  title: lesson.title,
                  duration: lesson.duration,
                  durationSeconds: lesson.durationSeconds,
                  completed: lesson.completed,
                  locked: lesson.locked,
                  playIconUrl: lesson.playIconUrl,
                  arrowIconUrl: lesson.arrowIconUrl,
                ).toJson())
            .toList(),
        'description': CourseDescriptionModel(text: description.text).toJson(),
      };
}

/// Modelul JSON al prețului.
class CoursePriceModel extends CoursePrice {
  const CoursePriceModel({
    required super.label,
    required super.amount,
    required super.currency,
  });

  factory CoursePriceModel.fromJson(Map<String, dynamic> json) {
    return CoursePriceModel(
      label: json['label'] as String? ?? '',
      amount: _asDouble(json['amount']),
      currency: json['currency'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'amount': amount,
        'currency': currency,
      };
}

/// Modelul JSON al acțiunii de înscriere.
class EnrollActionModel extends EnrollAction {
  const EnrollActionModel({
    required super.label,
    required super.enabled,
  });

  factory EnrollActionModel.fromJson(Map<String, dynamic> json) {
    return EnrollActionModel(
      label: json['label'] as String? ?? 'Enroll Now',
      enabled: json['enabled'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'enabled': enabled,
      };
}

/// Modelul JSON al acțiunilor.
class CourseActionsModel extends CourseActions {
  const CourseActionsModel({
    required super.price,
    required super.enroll,
  });

  factory CourseActionsModel.fromJson(Map<String, dynamic> json) {
    return CourseActionsModel(
      price: CoursePriceModel.fromJson(_asMap(json['price'])),
      enroll: EnrollActionModel.fromJson(_asMap(json['enroll'])),
    );
  }

  Map<String, dynamic> toJson() => {
        'price': CoursePriceModel(
          label: price.label,
          amount: price.amount,
          currency: price.currency,
        ).toJson(),
        'enroll': EnrollActionModel(
          label: enroll.label,
          enabled: enroll.enabled,
        ).toJson(),
      };
}

/// Modelul JSON al iconițelor de UI.
class CourseUiIconsModel extends CourseUiIcons {
  const CourseUiIconsModel({
    required super.durationIconUrl,
    required super.lessonsIconUrl,
    required super.ratingIconUrl,
  });

  factory CourseUiIconsModel.fromJson(Map<String, dynamic> json) {
    return CourseUiIconsModel(
      durationIconUrl: json['durationIconUrl'] as String? ?? '',
      lessonsIconUrl: json['lessonsIconUrl'] as String? ?? '',
      ratingIconUrl: json['ratingIconUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'durationIconUrl': durationIconUrl,
        'lessonsIconUrl': lessonsIconUrl,
        'ratingIconUrl': ratingIconUrl,
      };
}

/// Modelul JSON al răspunsului complet de detalii.
class CourseDetailsModel extends CourseDetails {
  const CourseDetailsModel({
    required super.navigation,
    required super.course,
    required super.actions,
    required super.uiIcons,
  });

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    return CourseDetailsModel(
      navigation:
          DetailsNavigationModel.fromJson(_asMap(json['navigation'])),
      course: CourseModel.fromJson(_asMap(json['course'])),
      actions: CourseActionsModel.fromJson(_asMap(json['actions'])),
      uiIcons: CourseUiIconsModel.fromJson(_asMap(json['uiIcons'])),
    );
  }

  Map<String, dynamic> toJson() => {
        'navigation': DetailsNavigationModel(
          title: navigation.title,
          backIconUrl: navigation.backIconUrl,
        ).toJson(),
        'course': CourseModel(
          id: course.id,
          title: course.title,
          duration: course.duration,
          durationMinutes: course.durationMinutes,
          lessonCount: course.lessonCount,
          rating: course.rating,
          hero: course.hero,
          tabs: course.tabs,
          lessons: course.lessons,
          description: course.description,
        ).toJson(),
        'actions': CourseActionsModel(
          price: actions.price,
          enroll: actions.enroll,
        ).toJson(),
        'uiIcons': CourseUiIconsModel(
          durationIconUrl: uiIcons.durationIconUrl,
          lessonsIconUrl: uiIcons.lessonsIconUrl,
          ratingIconUrl: uiIcons.ratingIconUrl,
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
