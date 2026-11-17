import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_bogdan_varianta3/features/learning/data/models/learning_feed_model.dart';

import 'helpers/fixtures.dart';

void main() {
  group('LearningFeedModel', () {
    test('deserializează header-ul, progresul și planul', () {
      final feed = LearningFeedModel.fromJson(sampleFeedJson);

      expect(feed.header.greeting, 'Hi, Kristin');
      expect(feed.header.subtitle, 'Let’s start learning');
      expect(feed.header.hasUnread, isTrue);
      expect(feed.header.notificationIconUrl, contains('bell-outline'));

      expect(feed.learnedToday.learnedMinutes, 46);
      expect(feed.learnedToday.goalMinutes, 60);
      expect(feed.learnedToday.formatted, '46min / 60min');
      expect(feed.learnedToday.progressPercent, 77);

      expect(feed.myCourses.title, 'My courses');
      expect(feed.learningPrompt.actionLabel, 'Get Started');
      expect(feed.learningPlan.items, hasLength(2));
      expect(feed.learningPlan.items.first.title, 'Packaging Design');
      expect(feed.learningPlan.items.first.progressLabel, '40/48');
      expect(feed.meetup.title, 'Meetup');
    });

    test('serializează feed-ul înapoi în JSON', () {
      final feed = LearningFeedModel.fromJson(sampleFeedJson);
      final json = feed.toJson();

      expect(json['header'], isA<Map>());
      expect((json['header'] as Map)['greeting'], 'Hi, Kristin');
      expect((json['learnedToday'] as Map)['learnedMinutes'], 46);
      expect(json['learningPlan'], isA<Map>());
      expect((json['learningPlan'] as Map)['items'], hasLength(2));
      expect((json['meetup'] as Map)['subtitle'],
          'Off-line exchange of learning experience');
    });

    test('acceptă câmpuri lipsă fără să arunce excepții', () {
      final feed = LearningFeedModel.fromJson(const {});

      expect(feed.header.greeting, 'Salut');
      expect(feed.header.hasUnread, isFalse);
      expect(feed.learnedToday.learnedMinutes, 0);
      expect(feed.learningPlan.items, isEmpty);
      expect(feed.meetup.title, '');
    });
  });
}
