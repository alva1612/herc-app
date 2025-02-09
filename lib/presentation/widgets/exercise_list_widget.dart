import 'package:flutter/material.dart';
import 'package:namer_app/config/helpers/get_exercises.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:provider/provider.dart';

class ExerciseListState extends ChangeNotifier {}

class ExerciseListWidget extends StatelessWidget {
  const ExerciseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ExerciseListState(), child: ExerciseList());
  }
}

class ExerciseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  late Future<List<Exercise>> exercises;

  @override
  void initState() {
    super.initState();
    exercises = GetExercises().getExercises();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: exercises,
        builder: (contextFuture, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (!snapshot.hasData) {
            return const Text('loading');
          }
          List<Exercise> loadedExercises = snapshot.data as List<Exercise>;
          return Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  ExerciseRow(exercise: snapshot.data![index]),
              itemCount: loadedExercises.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
            ),
          );
        });
  }
}

class ExerciseRow extends StatelessWidget {
  final Exercise exercise;

  const ExerciseRow({
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueGrey[700],
      ),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
              height: 54,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(exercise.description ?? '')
                ],
              ))),
    );
  }
}
