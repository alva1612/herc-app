import 'package:flutter/material.dart';
import 'package:namer_app/presentation/providers/exercises_screen_provider.dart';
import 'package:namer_app/presentation/widgets/exercise_list_widget.dart';
import 'package:namer_app/presentation/widgets/new_exercise_widget.dart';
import 'package:provider/provider.dart';

class ExercisesScreen extends StatelessWidget {
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

    return Column(children: [
      ExpansionPanelList(
        expansionCallback: (int index, bool isOpen) {
          toggleNewExercise(isOpen);
        },
        children: [
          ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text('Nuevo'),
                );
              },
              body: NewExerciseWidget(),
              isExpanded: isOpenNewExerciseToggle,
              canTapOnHeader: true)
        ],
      ),
      ExerciseListWidget()
    ]);
  }
}
