import 'package:flutter/material.dart';
import 'package:namer_app/config/helpers/exercise_service.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:provider/provider.dart';

class NewExerciseFormState extends ChangeNotifier {
  ExerciseCreateData newExercise = ExerciseCreateData();

  Future<void> createExercise() async {
    print(newExercise);
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

  setMuscleSectionExercises(List<MuscleExerciseOnCreate> me) {
    newExercise.setMuscleExercises(me);
    notifyListeners();
  }

  clear() {
    newExercise.setName('');
    newExercise.setDescription('');
    notifyListeners();
  }
}

class NewExerciseProvider extends StatelessWidget {
  final Widget child;
  const NewExerciseProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewExerciseFormState(),
      child: child,
    );
  }
}