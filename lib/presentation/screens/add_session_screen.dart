import 'package:flutter/material.dart';
import 'package:namer_app/config/helpers/create_temp_session.dart';
import 'package:namer_app/config/helpers/get_exercises.dart';
import 'package:namer_app/config/helpers/get_sessions.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:namer_app/domain/entities/temp_sessions.dart';
import 'package:namer_app/presentation/screens/history_screen.dart';
import 'package:provider/provider.dart';

class LastSessionByExerciseResult {
  final TempSession? session;
  final bool hasResult;

  const LastSessionByExerciseResult({this.session, required this.hasResult});
}

class AddSessionFormState extends ChangeNotifier {
  TempSessionCreateData trainingSession = TempSessionCreateData();
  Map<String, LastSessionByExerciseResult> lastSessionsByUuid = Map.from({});

  Future<void> createExercise() async {
    var creationFuture = CreateTempSession().create(trainingSession);
    await creationFuture;
    notifyListeners();
  }

  setSelectedExercise(String exerciseUuid) async {
    trainingSession.setExercise(exerciseUuid);
    if (lastSessionsByUuid[exerciseUuid] == null) {
      var lastSession =
          await GetSessions().getLastSessionByExercise(exerciseUuid);
      if (lastSession != null) {
        lastSessionsByUuid.addEntries(<String, LastSessionByExerciseResult>{
          exerciseUuid:
              LastSessionByExerciseResult(session: lastSession, hasResult: true)
        }.entries);
      } else {
        lastSessionsByUuid.addEntries(<String, LastSessionByExerciseResult>{
          exerciseUuid: LastSessionByExerciseResult(hasResult: false)
        }.entries);
      }
    }
    notifyListeners();
  }

  setReps(int reps) {
    trainingSession.setReps(reps);
    notifyListeners();
  }

  setWeight(double w) {
    trainingSession.setWeight(w);
    notifyListeners();
  }

  TempSession? getLastSessionByExercise() {
    if (trainingSession.exerciseUuid == null) {
      return null;
    }
    return lastSessionsByUuid[trainingSession.exerciseUuid]?.session;
  }
}

class AddSessionForm extends StatefulWidget {
  @override
  State<AddSessionForm> createState() => _AddSessionFormState();
}

class AddSessionScreen extends StatelessWidget {
  const AddSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddSessionFormState(),
      child: Column(
        spacing: 40,
        mainAxisSize: MainAxisSize.max,
        children: [
          AddSessionForm(),
          Expanded(
            child: HistoryList(),
          )
        ],
      ),
    );
  }
}

class _AddSessionFormState extends State<AddSessionForm> {
  late Future<List<Exercise>> exercises;

  @override
  void initState() {
    super.initState();
    exercises = GetExercises().getExercises();
  }

  @override
  Widget build(BuildContext context) {
    var formState = context.watch<AddSessionFormState>();
    var selectedExercise = formState.trainingSession.exerciseUuid;
    var setSelectedExercise = formState.setSelectedExercise;
    var setRepetitions = formState.setReps;
    var setWeight = formState.setWeight;
    var addToHistory = formState.createExercise;

    var lastSession = formState.getLastSessionByExercise();

    getRepetitionsInitialValue() {
      if (lastSession?.repetitions == null) {
        return null;
      }
      try {
        return lastSession!.repetitions.toString();
      } catch (e) {
        print(e.toString());
        return null;
      }
    }

    var repetitionsInitialValue = getRepetitionsInitialValue();

    return FutureBuilder(
        future: exercises,
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
                  initialValue: lastSession?.weight ?? '',
                  onChanged: (event) {
                    try {
                      setWeight(double.parse(event));
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                Text(lastSession?.weight ?? ''),
                TextFormField(
                  decoration: InputDecoration(labelText: "Repeticiones"),
                  keyboardType: TextInputType.number,
                  initialValue: repetitionsInitialValue,
                  onChanged: (event) {
                    try {
                      setRepetitions(int.parse(event));
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                Text(lastSession?.repetitions.toString() ?? ''),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // appState.toggleFavorite();
                        addToHistory();
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

class ExercsisesDropDown extends StatelessWidget {
  const ExercsisesDropDown({
    super.key,
    required this.selectedExercise,
    required this.setSelectedExercise,
    required this.exercises,
  });

  final String? selectedExercise;
  final Function(String exerciseUuid) setSelectedExercise;
  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedExercise,
        onChanged: (event) {
          if (event != null) {
            setSelectedExercise(event);
          }
        },
        items: exercises.map<DropdownMenuItem<String>>((Exercise ex) {
          return DropdownMenuItem<String>(
            value: ex.uuid,
            child: Text(ex.name),
          );
        }).toList());
  }
}
