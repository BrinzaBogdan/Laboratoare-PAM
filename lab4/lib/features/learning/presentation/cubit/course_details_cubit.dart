import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_course_details.dart';
import 'course_details_state.dart';

/// Încarcă detaliile cursului direct de la serviciul Web.
class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit(this._getCourseDetails)
      : super(const CourseDetailsState());

  final GetCourseDetails _getCourseDetails;

  Future<void> load() async {
    emit(const CourseDetailsState(status: CourseDetailsStatus.loading));

    try {
      final details = await _getCourseDetails();
      if (isClosed) return;

      emit(
        CourseDetailsState(
          status: CourseDetailsStatus.success,
          details: details,
          selectedTabId: details.course.tabs.selected,
        ),
      );
    } on Failure catch (failure) {
      if (isClosed) return;
      emit(
        CourseDetailsState(
          status: CourseDetailsStatus.failure,
          errorMessage: failure.message,
        ),
      );
    }
  }

  void selectTab(String id) {
    if (state.selectedTabId == id) return;
    emit(state.copyWith(selectedTabId: id));
  }
}
