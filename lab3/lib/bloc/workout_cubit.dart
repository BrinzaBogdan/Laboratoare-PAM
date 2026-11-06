import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/fitness_repository.dart';
import '../models/fitness_models.dart';
import 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit(this._repository) : super(const WorkoutLoading());

  final FitnessRepository _repository;

  FitnessData? _data;
  String _query = '';
  String _filterId = 'all';
  SortOption _sort = SortOption.name;
  final Set<String> _favorites = {};

  /// Incarca datele asincron si emite Loading -> Success/Empty sau Error.
  Future<void> load() async {
    emit(const WorkoutLoading());
    try {
      _data = await _repository.loadData();
      _emitView();
    } catch (e) {
      emit(WorkoutError('Nu am putut încărca datele. ($e)'));
    }
  }

  void setQuery(String value) {
    _query = value;
    _emitView();
  }

  void setFilter(String id) {
    _filterId = id;
    _emitView();
  }

  void setSort(SortOption sort) {
    _sort = sort;
    _emitView();
  }

  void toggleFavorite(String id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    _emitView();
  }

  void _emitView() {
    final data = _data;
    if (data == null) return;

    final visible = _applyFilters(data.programs);
    final favoriteIds = Set<String>.of(_favorites);

    if (visible.isEmpty) {
      emit(WorkoutEmpty(
        data: data,
        visiblePrograms: visible,
        query: _query,
        filterId: _filterId,
        sort: _sort,
        favoriteIds: favoriteIds,
      ));
    } else {
      emit(WorkoutSuccess(
        data: data,
        visiblePrograms: visible,
        query: _query,
        filterId: _filterId,
        sort: _sort,
        favoriteIds: favoriteIds,
      ));
    }
  }

  List<WorkoutProgram> _applyFilters(List<WorkoutProgram> programs) {
    final q = _query.trim().toLowerCase();

    final result = programs.where((p) {
      final byCategory = _filterId == 'all' || p.category == _filterId;
      final byQuery = q.isEmpty || p.title.toLowerCase().contains(q);
      return byCategory && byQuery;
    }).toList();

    switch (_sort) {
      case SortOption.name:
        result.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortOption.calories:
        result.sort((a, b) => b.calories.compareTo(a.calories));
        break;
      case SortOption.duration:
        result.sort((a, b) => a.durationMinutes.compareTo(b.durationMinutes));
        break;
    }
    return result;
  }
}
