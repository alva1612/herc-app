import 'package:flutter/material.dart';
import 'package:namer_app/config/helpers/exercise_service.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:provider/provider.dart';

class NewExerciseFormState extends ChangeNotifier {
  ExerciseCreateData newExercise = ExerciseCreateData();

  Future<void> createExercise() async {
    var creationFuture = await ExerciseService().create(newExercise);
    if (creationFuture) {
      clear();
    }
    notifyListeners();
  }

  setName(String n) {
    newExercise.setName(n);
    notifyListeners();
  }

  setDescription(String d) {
    newExercise.setDescription(d);
    notifyListeners();
  }

  clear() {
    newExercise.setName('');
    newExercise.setDescription('');
    notifyListeners();
  }
}

class NewExerciseForm extends StatefulWidget {
  @override
  State<NewExerciseForm> createState() => _NewExerciseFormState();
}

class NewExerciseWidget extends StatelessWidget {
  const NewExerciseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewExerciseFormState(),
      child: NewExerciseForm(),
    );
  }
}

class _NewExerciseFormState extends State<NewExerciseForm> {
  @override
  Widget build(BuildContext context) {
    var formState = context.watch<NewExerciseFormState>();
    var setDescription = formState.setDescription;
    var setName = formState.setName;
    var create = formState.createExercise;
    var clear = formState.clear;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Text('Nuevo:'),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Nombre"),
              keyboardType: TextInputType.number,
              onChanged: (event) {
                try {
                  setName(event);
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Descripción"),
          keyboardType: TextInputType.number,
          onChanged: (event) {
            try {
              setDescription(event);
            } catch (e) {
              print(e);
            }
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                create();
              },
              label: Text('Save'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                clear();
              },
              child: Text('Clear'),
            ),
          ],
        ),
      ],
    );
  }
}
