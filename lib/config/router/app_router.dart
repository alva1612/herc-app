import 'package:go_router/go_router.dart';
import 'package:namer_app/presentation/screens/add_session_screen.dart';
import 'package:namer_app/presentation/screens/core_config_screen.dart';
import 'package:namer_app/presentation/screens/exercises/exercises_screen.dart';
import 'package:namer_app/presentation/screens/exercises/new_exercise_screen.dart';
import 'package:namer_app/presentation/screens/history_screen.dart';
import 'package:namer_app/presentation/screens/home_screen.dart';
import 'package:namer_app/presentation/screens/muscle_section/muscle_section_management_screen.dart';

final appRouter = GoRouter(initialLocation: '/config', routes: [
  GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => HomeScreen()),
  GoRoute(path: '/config', builder: (context, state) => CoreConfigScreen()),
  GoRoute(
      path: '/exercise',
      name: ExercisesScreen.name,
      builder: (context, state) => ExercisesScreen()),
  GoRoute(
      path: '/exercise/new',
      name: NewExerciseScreen.name,
      builder: (context, state) => NewExerciseScreen()),
  GoRoute(
      path: '/muscle',
      builder: (context, state) => MuscleSectionManagementScreen()),
  GoRoute(
    path: '/session',
    builder: (context, state) => AddSessionScreen(),
  ),
  GoRoute(
      path: '/history',
      name: HistoryScreen.name,
      builder: (context, state) => HistoryScreen())
]);
