import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/learning/domain/repositories/learning_repository.dart';
import 'features/learning/domain/usecases/get_course_details.dart';
import 'features/learning/domain/usecases/get_learning_feed.dart';
import 'features/learning/presentation/cubit/feed_cubit.dart';
import 'features/learning/presentation/pages/feed_page.dart';

/// Rădăcina aplicației.
///
/// Injectarea dependențelor se face aici: repository-ul vine din `main`, iar
/// cazurile de utilizare sunt construite o singură dată și oferite cubitului.
class App extends StatelessWidget {
  const App({super.key, required this.repository});

  final LearningRepository repository;

  @override
  Widget build(BuildContext context) {
    final getLearningFeed = GetLearningFeed(repository);
    final getCourseDetails = GetCourseDetails(repository);

    return BlocProvider(
      create: (_) => FeedCubit(getLearningFeed: getLearningFeed)..load(),
      child: MaterialApp(
        title: 'Learning App',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: FeedPage(getCourseDetails: getCourseDetails),
      ),
    );
  }
}
