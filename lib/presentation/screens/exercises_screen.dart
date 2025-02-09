import 'package:flutter/material.dart';
import 'package:namer_app/presentation/widgets/exercise_list_widget.dart';
import 'package:namer_app/presentation/widgets/new_exercise_widget.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [NewExerciseWidget(), ExerciseListWidget()],
    );
  }
}
