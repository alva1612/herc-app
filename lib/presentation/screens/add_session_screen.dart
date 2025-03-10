import 'package:flutter/material.dart';
import 'package:namer_app/config/helpers/create_temp_session.dart';
import 'package:namer_app/config/helpers/get_exercises.dart';
import 'package:namer_app/config/helpers/get_sessions.dart';
import 'package:namer_app/config/helpers/get_sets.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:namer_app/domain/entities/training_session.dart';
import 'package:namer_app/domain/entities/training_session_set.dart';
import 'package:namer_app/presentation/widgets/history_list_widget.dart';
import 'package:provider/provider.dart';

class LastSessionByExerciseResult {
  final TrainingSessionOverload? session;
  final bool hasResult;

  const LastSessionByExerciseResult({this.session, required this.hasResult});
}

class AddSessionFormState extends ChangeNotifier {
  TrainingSessionSetCreateData trainingSession = TrainingSessionSetCreateData();
  Map<String, LastSessionByExerciseResult> lastSessionsByExerciseUuid =
      Map.from({});

  Future<void> createExercise() async {
    var creationFuture = CreateTempSession().create(trainingSession);
    await creationFuture;
    notifyListeners();
  }

  setSelectedExercise(String exerciseUuid) async {
    trainingSession.setExercise(Exercise(uuid: exerciseUuid));
    if (lastSessionsByExerciseUuid[exerciseUuid] == null) {
      var lastSession =
          await GetSessions().getLastSessionByExercise(exerciseUuid);
          print('lastSession');
          print(lastSession);
      if (lastSession != null) {
        lastSessionsByExerciseUuid.addEntries(
            <String, LastSessionByExerciseResult>{
          exerciseUuid:
              LastSessionByExerciseResult(session: lastSession, hasResult: true)
        }.entries);
      } else {
        lastSessionsByExerciseUuid.addEntries(
            <String, LastSessionByExerciseResult>{
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

  TrainingSessionOverload? getLastSessionByExercise() {
    if (trainingSession.exercise?.uuid == null) {
      return null;
    }
    return lastSessionsByExerciseUuid[trainingSession.exercise!.uuid]?.session;
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
            child: TodayHistoryList(),
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
    var selectedExercise = formState.trainingSession.exercise!.uuid;
    var setSelectedExercise = formState.setSelectedExercise;
    var setRepetitions = formState.setReps;
    var setWeight = formState.setWeight;
    var addToHistory = formState.createExercise;

    var lastSession = formState.getLastSessionByExercise();

    getMaxValuesLastSession() {
      if (lastSession == null) {
        return null;
      }
      // foldMaxValue(String property) {
      //   return (value, element) {
      //     final weight = double.parse(element[property]);
      //     if (weight > value) {
      //       return weight;
      //     } else {
      //       return value;
      //     }
      //   };
      // }
      // try {
      //   var maxWeight =
      //       lastSession.maxWeight;
      //   var maxRepetitions = lastSession.maxReps as double;
      //   return Map.from(<String, dynamic>{
      //     'maxWeight': maxWeight,
      //     'maxRepetitions': maxRepetitions
      //   });
      // } catch (e) {
      //   print(e.toString());
      //   return null;
      // }
      return lastSession;
    }

    var maxValues = getMaxValuesLastSession();

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
            child: Text(ex.name ?? ""),
          );
        }).toList());
  }
}

class TodayHistoryList extends StatefulWidget {
  const TodayHistoryList({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TodayHistoryListState();
}

class _TodayHistoryListState extends State {
  late Future<List<TrainingSessionSet>> sessions;

  @override
  void initState() {
    super.initState();
    sessions = GetSets().getSets('today');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: sessions,
        builder: (contextFuture, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (!snapshot.hasData) {
            return const Text('loading');
          }
          return HistoryListWidget(sets: snapshot.data!);
        });
  }
}
