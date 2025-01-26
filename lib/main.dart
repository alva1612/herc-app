import 'package:flutter/material.dart';
import 'package:namer_app/config/helpers/create_temp_session.dart';
import 'package:namer_app/config/helpers/get_exercises.dart';
import 'package:namer_app/config/helpers/get_sessions.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:namer_app/domain/entities/temp_sessions.dart';
import 'package:namer_app/presentation/pages/history_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final getSessionsQuery = GetSessions();
  List<TempSession> sessions = [];
  List<Exercise> exercises = [];

  Future<void> setSessions(Future<List<TempSession>> sessionFuture) async {
    sessionFuture.then((value) {
      sessions = value;
      notifyListeners();
    });
  }

  Future<void> setExercises(Future<List<Exercise>> exercisesFuture) async {
    exercisesFuture.then((value) {
      exercises = value;
      notifyListeners();
    });
  }

  refreshTrainingSessions() {
    setSessions(GetSessions().getSessions());
  }

  TempSessionCreateData trainingSession = TempSessionCreateData();
  createExercise() async {
    var creationFuture = CreateTempSession().create(trainingSession);
    await creationFuture;
    await refreshTrainingSessions();
    notifyListeners();
  }

  setSelectedExercise(String exerciseUuid) {
    trainingSession.setExercise(exerciseUuid);
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
}

// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  var sessions = GetSessions().getSessions();
  var exercises = GetExercises().getExercises();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    appState.setSessions(sessions);
    appState.setExercises(exercises);

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = AddSessionPage();
      case 1:
        page = HistoryPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                  print('selected: $value');
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class AddSessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var exercises = appState.exercises;
    var selectedExercise = appState.trainingSession.exerciseUuid;
    var setSelectedExercise = appState.setSelectedExercise;
    var setRepetitions = appState.setReps;
    var setWeight = appState.setWeight;
    var addToHistory = appState.createExercise;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('Registrar:'),
          ),
          DropdownButton(
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
              }).toList()),
          SizedBox(height: 10),
          TextField(
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
          TextField(
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
  }
}
