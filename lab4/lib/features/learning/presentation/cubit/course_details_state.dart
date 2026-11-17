import 'package:equatable/equatable.dart';

import '../../domain/entities/course_details.dart';

enum CourseDetailsStatus { initial, loading, success, failure }

/// Starea ecranului „Course Overview”.
class CourseDetailsState extends Equatable {
  const CourseDetailsState({
    this.status = CourseDetailsStatus.initial,
    this.details,
    this.errorMessage,
    this.selectedTabId = 'lessons',
  });

  final CourseDetailsStatus status;
  final CourseDetails? details;
  final String? errorMessage;
  final String selectedTabId;

  CourseDetailsState copyWith({
    CourseDetailsStatus? status,
    CourseDetails? details,
    String? errorMessage,
    String? selectedTabId,
    bool clearError = false,
  }) {
    return CourseDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      selectedTabId: selectedTabId ?? this.selectedTabId,
    );
  }

  @override
  List<Object?> get props => [status, details, errorMessage, selectedTabId];
}
