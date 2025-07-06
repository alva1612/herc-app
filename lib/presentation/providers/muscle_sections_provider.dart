import 'package:namer_app/config/helpers/muscle_section_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'muscle_sections_provider.g.dart';

@riverpod
Future<List<MuscleSection>> muscleSections(Ref ref) async {
  return MuscleSectionService.getMuscleSections("");
}