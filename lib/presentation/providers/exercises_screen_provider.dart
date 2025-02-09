import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExercisesScreenState extends ChangeNotifier {
  bool newExerciseToggle = false;

  void toggleNewExercise(bool? toggleTo) {
    if (toggleTo == null) {
      newExerciseToggle = !newExerciseToggle;
      return;
    }
    newExerciseToggle = toggleTo;
    notifyListeners();
  }
}

class ExercisesScreenProvider extends StatelessWidget {
  final Widget child;
  const ExercisesScreenProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ExercisesScreenState(), child: child);
  }
}
