import 'package:flutter/material.dart';
import 'package:namer_app/presentation/widgets/new_exercise_form_widget.dart';

class NewExerciseScreen extends StatelessWidget {
  static const name = 'new_exercise_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo ejercicio'),
      ),
      body: NewExerciseWidget(),
    );
  }
}
