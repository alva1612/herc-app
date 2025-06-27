import 'package:go_router/go_router.dart';
import 'package:namer_app/presentation/screens/add_session_screen.dart';
import 'package:namer_app/presentation/screens/core_config_screen.dart';
import 'package:namer_app/presentation/screens/exercises_screen.dart';
import 'package:namer_app/presentation/screens/history_screen.dart';
import 'package:namer_app/presentation/screens/home_screen.dart';
import 'package:namer_app/presentation/screens/muscle_section/muscle_section_management_screen.dart';

final appRouter = GoRouter(initialLocation: '/config', routes: [
  GoRoute(path: '/', builder: (context, state) => HomeScreen()),
  GoRoute(path: '/config', builder: (context, state) => CoreConfigScreen()),
  GoRoute(path: '/exercise', builder: (context, state) => ExercisesScreen()),
  GoRoute(
      path: '/muscle',
      builder: (context, state) => MuscleSectionManagementScreen()),
  GoRoute(
    path: '/session',
    builder: (context, state) => AddSessionScreen(),
  ),
  GoRoute(path: '/history', builder: (context, state) => HistoryScreen())
]);
