import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/config/helpers/exercise_service.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:namer_app/presentation/providers/exercises_provider.dart';

class ExerciseListState extends ChangeNotifier {}

class ExerciseListWidget extends ConsumerWidget {
  final List<Exercise> exercises;
  const ExerciseListWidget({super.key, required this.exercises});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 16),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) => ExerciseRow(
          exercise: exercises[index],
          onDelete: () {
            ref.read(exerciseListProvider.notifier).delete(exercises[index].uuid!);
          },
        ),
        itemCount: exercises.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 16,
        ),
      ),
    );
  }
}

class ExerciseRow extends StatelessWidget {
  final Exercise exercise;
  final Function? onDelete;

  const ExerciseRow({
    required this.exercise,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        exercise.name ?? "",
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text(exercise.description ?? ""),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          // Handle delete action
          ExerciseService.delete(exercise.uuid!).then((value) {
            if (value && onDelete != null) {
              onDelete!();
            }
          });
        },
      ),
      onTap: () {
        // Handle tap if needed
      },
    );
  }
}
