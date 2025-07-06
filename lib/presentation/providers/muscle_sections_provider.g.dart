// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_sections_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(muscleSections)
const muscleSectionsProvider = MuscleSectionsProvider._();

final class MuscleSectionsProvider extends $FunctionalProvider<
        AsyncValue<List<MuscleSection>>,
        List<MuscleSection>,
        FutureOr<List<MuscleSection>>>
    with
        $FutureModifier<List<MuscleSection>>,
        $FutureProvider<List<MuscleSection>> {
  const MuscleSectionsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'muscleSectionsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$muscleSectionsHash();

  @$internal
  @override
  $FutureProviderElement<List<MuscleSection>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<MuscleSection>> create(Ref ref) {
    return muscleSections(ref);
  }
}

String _$muscleSectionsHash() => r'1e458d5d22c2626ed3ae1599a481a873712e2fff';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
