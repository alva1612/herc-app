import 'package:flutter/material.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:namer_app/presentation/screens/add_session_screen.dart';
import 'package:provider/provider.dart';

class AddSessionForm extends StatefulWidget {
  final Future<List<Exercise>> exercises;
  final Function? onAddSessionComplete;
  
  const AddSessionForm({
    super.key,
    required this.exercises,
    this.onAddSessionComplete,
  });

  @override
  State<AddSessionForm> createState() => _AddSessionFormState();
}

class _AddSessionFormState extends State<AddSessionForm> {
  late Future<List<Exercise>> exercises;

  @override
  Widget build(BuildContext context) {
    var formState = context.watch<AddSessionScreenState>();
    var selectedExercise = formState.trainingSession.exercise!.uuid;
    var setSelectedExercise = formState.setSelectedExercise;
    var setRepetitions = formState.setReps;
    var setWeight = formState.setWeight;
    var addToHistory = formState.createExercise;

    var lastSession = formState.getLastSessionByExercise();
    var maxValues = lastSession;

    onCreateExercise() async {
      await addToHistory();
      if (widget.onAddSessionComplete != null) {
        widget.onAddSessionComplete!();
      }
    }

    return FutureBuilder(
        future: widget.exercises,
        builder: (contextFuture, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (!snapshot.hasData) {
            return const Text('loading');
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Registrar:'),
                ),
                SizedBox(height: 10),
                ExercsisesDropDown(
                    selectedExercise: selectedExercise,
                    setSelectedExercise: setSelectedExercise,
                    exercises: snapshot.data!),
                TextFormField(
                  decoration: InputDecoration(labelText: "Peso"),
                  keyboardType: TextInputType.number,
                  onChanged: (event) {
                    try {
                      setWeight(double.parse(event));
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                Text(maxValues != null ? maxValues.maxWeight : ''),
                TextFormField(
                  decoration: InputDecoration(labelText: "Repeticiones"),
                  keyboardType: TextInputType.number,
                  onChanged: (event) {
                    try {
                      setRepetitions(int.parse(event));
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                Text(maxValues != null ? maxValues.maxReps.toString() : ''),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // appState.toggleFavorite();
                        onCreateExercise();
                      },
                      label: Text('Save'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // appState.getNext();
                      },
                      child: Text('Clear'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
