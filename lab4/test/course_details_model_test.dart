import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_bogdan_varianta3/data/models/course_details_model.dart';

import 'helpers/fixtures.dart';

void main() {
  group('CourseDetailsModel', () {
    test('deserializează cursul, lecțiile și acțiunile', () {
      final details = CourseDetailsModel.fromJson(sampleDetailsJson);

      expect(details.navigation.title, 'Course Overview');
      expect(details.course.id, 'react-front-to-back');
      expect(details.course.title, 'React Front To back');
      expect(details.course.duration, '6h 30min');
      expect(details.course.lessonCount, 7);
      expect(details.course.rating, 4.9);
      expect(details.course.hero.videoCount, 75);
      expect(details.course.hero.classCount, 35);
      expect(details.course.tabs.selected, 'lessons');
      expect(details.course.tabs.items, hasLength(2));
      expect(details.course.lessons, hasLength(4));
      expect(details.course.lessons[1].completed, isFalse);
      expect(details.course.lessons[3].locked, isTrue);
      expect(details.course.description.isEmpty, isTrue);
      expect(details.actions.price.label, 'Free');
      expect(details.actions.enroll.enabled, isTrue);
      expect(details.uiIcons.ratingIconUrl, contains('star'));
    });

    test('serializează detaliile înapoi în JSON', () {
      final details = CourseDetailsModel.fromJson(sampleDetailsJson);
      final json = details.toJson();

      expect(json['navigation'], isA<Map>());
      expect((json['course'] as Map)['title'], 'React Front To back');
      expect((json['course'] as Map)['lessons'], hasLength(4));
      expect((json['actions'] as Map)['price'], isA<Map>());
      expect((json['uiIcons'] as Map)['lessonsIconUrl'], contains('book-open'));
    });

    test('acceptă câmpuri lipsă fără să arunce excepții', () {
      final details = CourseDetailsModel.fromJson(const {});

      expect(details.navigation.title, 'Course Overview');
      expect(details.course.title, '');
      expect(details.course.lessons, isEmpty);
      expect(details.course.tabs.items, isEmpty);
      expect(details.actions.enroll.enabled, isFalse);
    });
  });
}
