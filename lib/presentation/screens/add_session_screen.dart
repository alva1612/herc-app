import 'package:flutter/material.dart';
import 'package:namer_app/config/helpers/create_temp_session.dart';
import 'package:namer_app/config/helpers/exercise_service.dart';
import 'package:namer_app/config/helpers/get_sessions.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:namer_app/domain/entities/training_session.dart';
import 'package:namer_app/domain/entities/training_session_set.dart';
import 'package:namer_app/presentation/widgets/add_session_form.dart';
import 'package:namer_app/presentation/widgets/history_list_widget.dart';
import 'package:provider/provider.dart';

class LastSessionByExerciseResult {
  final TrainingSessionOverload? session;
  final bool hasResult;

  const LastSessionByExerciseResult({this.session, required this.hasResult});
}

class AddSessionScreenState extends ChangeNotifier {
  TrainingSessionSetCreateData trainingSession = TrainingSessionSetCreateData();
  Map<String, LastSessionByExerciseResult> lastSessionsByExerciseUuid =
      Map.from({});

  Future<void> createExercise() async {
    var creationFuture = CreateTempSession().create(trainingSession);
    await creationFuture;
    notifyListeners();
  }

  Future<void> setSelectedExercise(String exerciseUuid) async {
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

  void setReps(int reps) {
    trainingSession.setReps(reps);
    notifyListeners();
  }

  void setWeight(double w) {
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

class AddSessionScreen extends StatelessWidget {
  const AddSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AddSessionScreenLayout());
  }
}

class _AddSessionScreenState extends State {
  late Future<List<TrainingSession>> sessions;
  late Future<List<Exercise>> exercises;

  @override
  void initState() {
    super.initState();
    sessions = GetSessions().getSessions('today');
    exercises = ExerciseService.getExercises();
  }

  void refreshHistory() {
    setState(() {
      sessions = GetSessions().getSessions('today');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 40,
      mainAxisSize: MainAxisSize.max,
      children: [
        ChangeNotifierProvider(
          create: (context) => AddSessionScreenState(),
          child: AddSessionForm(
            exercises: exercises,
            onAddSessionComplete: refreshHistory,
          ),
        ),
        Expanded(
            child: FutureBuilder(
                future: sessions,
                builder: (contextFuture, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('error');
                  }
                  if (!snapshot.hasData) {
                    return const Text('loading');
                  }
                  return SessionHistoryList(sessions: snapshot.data!);
                }))
      ],
    );
  }
}

class AddSessionScreenLayout extends StatefulWidget {
  const AddSessionScreenLayout({super.key});

  @override
  State<StatefulWidget> createState() => _AddSessionScreenState();
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

class TodayHistoryListWithFuture extends StatelessWidget {
  final Future<List<TrainingSession>> sessions;

  const TodayHistoryListWithFuture({super.key, required this.sessions});

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
          return SessionHistoryList(sessions: snapshot.data!);
        });
  }
}
