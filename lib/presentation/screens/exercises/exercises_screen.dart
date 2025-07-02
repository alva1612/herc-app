import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/presentation/providers/exercises_screen_provider.dart';
import 'package:namer_app/presentation/screens/exercises/new_exercise_screen.dart';
import 'package:namer_app/presentation/widgets/exercise_list_widget.dart';
import 'package:provider/provider.dart';

class ExercisesScreen extends StatelessWidget {
  static final name = 'exercises_screen';

  @override
  Widget build(BuildContext context) {
    return ExercisesScreenProvider(child: ExercisesScreenStateful());
  }
}

class ExercisesScreenStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExercisesScreen();
}

class _ExercisesScreen extends State<ExercisesScreenStateful> {
  @override
  Widget build(BuildContext context) {
    var screenState = context.watch<ExercisesScreenState>();
    var isOpenNewExerciseToggle = screenState.newExerciseToggle;
    var toggleNewExercise = screenState.toggleNewExercise;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios'),
      ),
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              context.pushNamed(NewExerciseScreen.name);
            },
            child: Text('Nuevo')),
        ExerciseListWidget()
      ]),
    );
  }
}
