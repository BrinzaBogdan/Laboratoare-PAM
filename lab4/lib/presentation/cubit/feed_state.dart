import 'package:equatable/equatable.dart';

import '../../domain/entities/learning_feed.dart';

enum FeedStatus { initial, loading, success, failure }

/// Starea feed-ului de learning.
///
/// Este imutabilă: fiecare schimbare produce o stare nouă.
class FeedState extends Equatable {
  const FeedState({
    this.status = FeedStatus.initial,
    this.feed,
    this.errorMessage,
  });

  final FeedStatus status;
  final LearningFeed? feed;
  final String? errorMessage;

  FeedState copyWith({
    FeedStatus? status,
    LearningFeed? feed,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FeedState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, feed, errorMessage];
}
