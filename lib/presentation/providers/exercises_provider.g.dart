// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ExerciseList)
const exerciseListProvider = ExerciseListProvider._();

final class ExerciseListProvider
    extends $AsyncNotifierProvider<ExerciseList, List<Exercise>> {
  const ExerciseListProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'exerciseListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$exerciseListHash();

  @$internal
  @override
  ExerciseList create() => ExerciseList();
}

String _$exerciseListHash() => r'79b30da2aabfedc083e17f28478ec8752015eb7f';

abstract class _$ExerciseList extends $AsyncNotifier<List<Exercise>> {
  FutureOr<List<Exercise>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Exercise>>, List<Exercise>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Exercise>>, List<Exercise>>,
        AsyncValue<List<Exercise>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
