import '../models/fitness_models.dart';

enum SortOption { name, calories, duration }

extension SortOptionLabel on SortOption {
  String get label => switch (this) {
        SortOption.name => 'Nume (A-Z)',
        SortOption.calories => 'Calorii (mare → mic)',
        SortOption.duration => 'Durată (scurt → lung)',
      };
}

/// Starile aplicatiei. Sealed, deci switch-ul din UI este exhaustiv.
sealed class WorkoutState {
  const WorkoutState();
}

/// Se incarca datele din JSON.
class WorkoutLoading extends WorkoutState {
  const WorkoutLoading();
}

/// Datele nu au putut fi incarcate.
class WorkoutError extends WorkoutState {
  final String message;
  const WorkoutError(this.message);
}

/// Date incarcate. Subclasele arata daca lista filtrata are elemente.
sealed class WorkoutLoaded extends WorkoutState {
  final FitnessData data;
  final List<WorkoutProgram> visiblePrograms;
  final String query;
  final String filterId;
  final SortOption sort;
  final Set<String> favoriteIds;

  const WorkoutLoaded({
    required this.data,
    required this.visiblePrograms,
    required this.query,
    required this.filterId,
    required this.sort,
    required this.favoriteIds,
  });
}

/// Exista cel putin un program dupa cautare si filtrare.
class WorkoutSuccess extends WorkoutLoaded {
  const WorkoutSuccess({
    required super.data,
    required super.visiblePrograms,
    required super.query,
    required super.filterId,
    required super.sort,
    required super.favoriteIds,
  });
}

/// Nu exista niciun program dupa cautare si filtrare.
class WorkoutEmpty extends WorkoutLoaded {
  const WorkoutEmpty({
    required super.data,
    required super.visiblePrograms,
    required super.query,
    required super.filterId,
    required super.sort,
    required super.favoriteIds,
  });
}
