import 'package:flutter/material.dart';
import 'package:namer_app/presentation/providers/new_exercise_provider.dart';
import 'package:provider/provider.dart';

class NewExerciseForm extends StatefulWidget {
  @override
  State<NewExerciseForm> createState() => _NewExerciseFormState();
}

class NewExerciseWidget extends StatelessWidget {
  const NewExerciseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NewExerciseProvider(child: NewExerciseForm());
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
