// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_sections_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(MuscleSectionsList)
const muscleSectionsListProvider = MuscleSectionsListProvider._();

final class MuscleSectionsListProvider
    extends $AsyncNotifierProvider<MuscleSectionsList, List<MuscleSection>> {
  const MuscleSectionsListProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'muscleSectionsListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$muscleSectionsListHash();

  @$internal
  @override
  MuscleSectionsList create() => MuscleSectionsList();
}

String _$muscleSectionsListHash() =>
    r'4aa40573d257f9aff98033fc5cb109e4da74bfb6';

abstract class _$MuscleSectionsList
    extends $AsyncNotifier<List<MuscleSection>> {
  FutureOr<List<MuscleSection>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<MuscleSection>>, List<MuscleSection>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<MuscleSection>>, List<MuscleSection>>,
        AsyncValue<List<MuscleSection>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
