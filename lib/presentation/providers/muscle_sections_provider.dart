import 'package:namer_app/config/helpers/muscle_section_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'muscle_sections_provider.g.dart';

@riverpod
class MuscleSectionsList extends _$MuscleSectionsList {
  @override
  Future<List<MuscleSection>> build() async {
    return MuscleSectionService.get("");
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => MuscleSectionService.get(""));
  }

  Future<void> delete(String muscleSectionUuid) async {
    final success = await MuscleSectionService.delete(muscleSectionUuid);
    if (success) {
      state = AsyncValue.data(state.value!.where((e) => e.uuid != muscleSectionUuid).toList());
    }
  }
}