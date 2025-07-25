import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:namer_app/presentation/providers/exercises_provider.dart';
import 'package:namer_app/presentation/widgets/ui/generic_list_widget.dart';

class ExerciseListWidget extends ConsumerWidget {
  final List<Exercise> exercises;
  const ExerciseListWidget({super.key, required this.exercises});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GenericListWidget(items: exercises.map((e) => e.toGenericListItems()).toList(), onDelete: (exercise) {
      ref.read(exerciseListProvider.notifier).delete(exercise.uuid!);
    });
  }
}