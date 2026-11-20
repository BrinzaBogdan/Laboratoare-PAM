import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_learning_feed.dart';
import 'feed_state.dart';

/// Coordonează fluxul UI -> use case -> repository -> API și înapoi.
///
/// Nu cunoaște HTTP, JSON sau widget-uri: depinde doar de cazul de utilizare
/// din `domain`.
class FeedCubit extends Cubit<FeedState> {
  FeedCubit({required this.getLearningFeed}) : super(const FeedState());

  final GetLearningFeed getLearningFeed;

  /// Identificatorul ultimei cereri, pentru a ignora răspunsurile întârziate.
  int _requestId = 0;

  Future<void> load() async {
    final requestId = ++_requestId;

    emit(
      const FeedState(status: FeedStatus.loading),
    );

    try {
      final feed = await getLearningFeed();
      if (isClosed || requestId != _requestId) return;

      emit(
        FeedState(status: FeedStatus.success, feed: feed),
      );
    } on Failure catch (failure) {
      if (isClosed || requestId != _requestId) return;
      emit(
        FeedState(
          status: FeedStatus.failure,
          errorMessage: failure.message,
        ),
      );
    }
  }

  Future<void> refresh() => load();

  Future<void> retry() => load();
}
