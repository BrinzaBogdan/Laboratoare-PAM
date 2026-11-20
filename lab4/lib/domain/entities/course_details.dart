import 'package:equatable/equatable.dart';

/// Entitățile de business ale ecranului „Course Overview”.

/// Bara de navigare a ecranului de detalii.
class DetailsNavigation extends Equatable {
  const DetailsNavigation({required this.title, required this.backIconUrl});

  final String title;
  final String backIconUrl;

  @override
  List<Object?> get props => [title, backIconUrl];
}

/// Hero-ul cursului: imagine, etichetă, buton play și statistici.
class CourseHero extends Equatable {
  const CourseHero({
    required this.label,
    required this.imageUrl,
    required this.playIconUrl,
    required this.videoCount,
    required this.classCount,
  });

  final String label;
  final String imageUrl;
  final String playIconUrl;
  final int videoCount;
  final int classCount;

  @override
  List<Object?> get props => [
        label,
        imageUrl,
        playIconUrl,
        videoCount,
        classCount,
      ];
}

/// Un tab din ecranul de detalii (Lessons / Description).
class CourseTab extends Equatable {
  const CourseTab({
    required this.id,
    required this.label,
    required this.selected,
  });

  final String id;
  final String label;
  final bool selected;

  @override
  List<Object?> get props => [id, label, selected];
}

/// Colecția de tab-uri și tab-ul selectat implicit.
class CourseTabs extends Equatable {
  const CourseTabs({required this.selected, required this.items});

  final String selected;
  final List<CourseTab> items;

  @override
  List<Object?> get props => [selected, items];
}

/// O lecție din curs.
class Lesson extends Equatable {
  const Lesson({
    required this.id,
    required this.title,
    required this.duration,
    required this.durationSeconds,
    required this.completed,
    required this.locked,
    required this.playIconUrl,
    required this.arrowIconUrl,
  });

  final String id;
  final String title;
  final String duration;
  final int durationSeconds;
  final bool completed;
  final bool locked;
  final String playIconUrl;
  final String arrowIconUrl;

  @override
  List<Object?> get props => [
        id,
        title,
        duration,
        durationSeconds,
        completed,
        locked,
        playIconUrl,
        arrowIconUrl,
      ];
}

/// Descrierea cursului.
class CourseDescription extends Equatable {
  const CourseDescription({required this.text});

  final String text;

  bool get isEmpty => text.trim().isEmpty;

  @override
  List<Object?> get props => [text];
}

/// Cursul propriu-zis.
class Course extends Equatable {
  const Course({
    required this.id,
    required this.title,
    required this.duration,
    required this.durationMinutes,
    required this.lessonCount,
    required this.rating,
    required this.hero,
    required this.tabs,
    required this.lessons,
    required this.description,
  });

  final String id;
  final String title;
  final String duration;
  final int durationMinutes;
  final int lessonCount;
  final double rating;
  final CourseHero hero;
  final CourseTabs tabs;
  final List<Lesson> lessons;
  final CourseDescription description;

  @override
  List<Object?> get props => [
        id,
        title,
        duration,
        durationMinutes,
        lessonCount,
        rating,
        hero,
        tabs,
        lessons,
        description,
      ];
}

/// Prețul cursului.
class CoursePrice extends Equatable {
  const CoursePrice({
    required this.label,
    required this.amount,
    required this.currency,
  });

  final String label;
  final double amount;
  final String currency;

  @override
  List<Object?> get props => [label, amount, currency];
}

/// Acțiunea de înscriere.
class EnrollAction extends Equatable {
  const EnrollAction({required this.label, required this.enabled});

  final String label;
  final bool enabled;

  @override
  List<Object?> get props => [label, enabled];
}

/// Acțiunile disponibile pe ecranul de detalii.
class CourseActions extends Equatable {
  const CourseActions({required this.price, required this.enroll});

  final CoursePrice price;
  final EnrollAction enroll;

  @override
  List<Object?> get props => [price, enroll];
}

/// Iconițele livrate de API pentru rândul de metadate.
class CourseUiIcons extends Equatable {
  const CourseUiIcons({
    required this.durationIconUrl,
    required this.lessonsIconUrl,
    required this.ratingIconUrl,
  });

  final String durationIconUrl;
  final String lessonsIconUrl;
  final String ratingIconUrl;

  @override
  List<Object?> get props => [
        durationIconUrl,
        lessonsIconUrl,
        ratingIconUrl,
      ];
}

/// Răspunsul complet al endpoint-ului de detalii.
class CourseDetails extends Equatable {
  const CourseDetails({
    required this.navigation,
    required this.course,
    required this.actions,
    required this.uiIcons,
  });

  final DetailsNavigation navigation;
  final Course course;
  final CourseActions actions;
  final CourseUiIcons uiIcons;

  @override
  List<Object?> get props => [navigation, course, actions, uiIcons];
}
