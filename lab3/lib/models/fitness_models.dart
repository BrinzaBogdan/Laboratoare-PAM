// Modelele de date, construite din fitness.json.

class FitnessData {
  final String date;
  final String greeting;
  final bool hasUnread;
  final ChallengeInfo challenge;
  final List<FeaturedPlan> featuredPlans;
  final List<FilterOption> filters;
  final List<WorkoutProgram> programs;
  final GymDetails gym;

  const FitnessData({
    required this.date,
    required this.greeting,
    required this.hasUnread,
    required this.challenge,
    required this.featuredPlans,
    required this.filters,
    required this.programs,
    required this.gym,
  });

  factory FitnessData.fromJson(Map<String, dynamic> json) {
    final home = json['fitnessHomePage'] as Map<String, dynamic>;
    final header = home['header'] as Map<String, dynamic>;
    final notification = header['notification'] as Map<String, dynamic>;
    final workout = home['workoutPrograms'] as Map<String, dynamic>;

    return FitnessData(
      date: header['date'] as String,
      greeting: header['greeting'] as String,
      hasUnread: notification['hasUnread'] as bool,
      challenge:
          ChallengeInfo.fromJson(home['todaysChallenge'] as Map<String, dynamic>),
      featuredPlans: (home['featuredPlans'] as List)
          .map((e) => FeaturedPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      filters: (workout['filters'] as List)
          .map((e) => FilterOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      programs: (workout['items'] as List)
          .map((e) => WorkoutProgram.fromJson(e as Map<String, dynamic>))
          .toList(),
      gym: GymDetails.fromJson(
          json['fitnessGymDetailsPage'] as Map<String, dynamic>),
    );
  }
}

class ChallengeInfo {
  final String title;
  final String activity;
  final int completed;
  final int total;
  final double progress;

  const ChallengeInfo({
    required this.title,
    required this.activity,
    required this.completed,
    required this.total,
    required this.progress,
  });

  factory ChallengeInfo.fromJson(Map<String, dynamic> j) => ChallengeInfo(
        title: j['title'] as String,
        activity: j['activity'] as String,
        completed: j['completed'] as int,
        total: j['total'] as int,
        progress: (j['progress'] as num).toDouble(),
      );
}

class FeaturedPlan {
  final String id;
  final String title;
  final String duration;
  final String frequency;
  final String actionLabel;
  final String imageUrl;

  const FeaturedPlan({
    required this.id,
    required this.title,
    required this.duration,
    required this.frequency,
    required this.actionLabel,
    required this.imageUrl,
  });

  factory FeaturedPlan.fromJson(Map<String, dynamic> j) => FeaturedPlan(
        id: j['id'] as String,
        title: j['title'] as String,
        duration: j['duration'] as String,
        frequency: j['frequency'] as String,
        actionLabel: j['actionLabel'] as String,
        imageUrl: j['imageUrl'] as String,
      );
}

class FilterOption {
  final String id;
  final String name;

  const FilterOption({required this.id, required this.name});

  factory FilterOption.fromJson(Map<String, dynamic> j) =>
      FilterOption(id: j['id'] as String, name: j['name'] as String);
}

class WorkoutProgram {
  final String id;
  final String title;
  final String category;
  final int calories;
  final int durationMinutes;
  final bool isPro;
  final String imageUrl;

  const WorkoutProgram({
    required this.id,
    required this.title,
    required this.category,
    required this.calories,
    required this.durationMinutes,
    required this.isPro,
    required this.imageUrl,
  });

  factory WorkoutProgram.fromJson(Map<String, dynamic> j) => WorkoutProgram(
        id: j['id'] as String,
        title: j['title'] as String,
        category: j['category'] as String,
        calories: j['calories'] as int,
        durationMinutes: j['durationMinutes'] as int,
        isPro: j['isPro'] as bool,
        imageUrl: j['imageUrl'] as String,
      );
}

class GymDetails {
  final String id;
  final String name;
  final String location;
  final String heroImageUrl;
  final double rating;
  final int reviewCount;
  final String description;
  final List<Amenity> amenities;
  final String priceText;
  final String reserveLabel;

  const GymDetails({
    required this.id,
    required this.name,
    required this.location,
    required this.heroImageUrl,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.amenities,
    required this.priceText,
    required this.reserveLabel,
  });

  factory GymDetails.fromJson(Map<String, dynamic> page) {
    final gym = page['gym'] as Map<String, dynamic>;
    final actions = page['actions'] as Map<String, dynamic>;
    final pricing = gym['pricing'] as Map<String, dynamic>;
    final reserve = actions['reserve'] as Map<String, dynamic>;

    return GymDetails(
      id: gym['id'] as String,
      name: gym['name'] as String,
      location: gym['location'] as String,
      heroImageUrl: gym['heroImageUrl'] as String,
      rating: (gym['rating'] as num).toDouble(),
      reviewCount: gym['reviewCount'] as int,
      description: gym['description'] as String,
      amenities: (gym['amenities'] as List)
          .map((e) => Amenity.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceText: pricing['formatted'] as String,
      reserveLabel: reserve['label'] as String,
    );
  }
}

class Amenity {
  final String id;
  final String name;
  final String iconUrl;

  const Amenity({required this.id, required this.name, required this.iconUrl});

  factory Amenity.fromJson(Map<String, dynamic> j) => Amenity(
        id: j['id'] as String,
        name: j['name'] as String,
        iconUrl: j['iconUrl'] as String,
      );
}
