import 'package:namer_app/config/helpers/exercise_service.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercises_provider.g.dart';

@riverpod
class ExerciseList extends _$ExerciseList {
  @override
  Future<List<Exercise>> build() async {
    return ExerciseService.get();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ExerciseService.get());
  }

  Future<void> delete(String exerciseUuid) async {
    final success = await ExerciseService.delete(exerciseUuid);
    print('Deleting exercise with UUID: $exerciseUuid');
    print(success);
    if (success) {
      state = AsyncValue.data(state.value!.where((e) => e.uuid != exerciseUuid).toList());
    }
  }
}