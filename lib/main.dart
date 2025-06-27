import 'package:flutter/material.dart';
import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/config/router/app_router.dart';
import 'package:namer_app/presentation/screens/add_session_screen.dart';
import 'package:namer_app/presentation/screens/core_config_screen.dart';
import 'package:namer_app/presentation/screens/exercises_screen.dart';
import 'package:namer_app/presentation/screens/history_screen.dart';
import 'package:namer_app/presentation/screens/home_screen.dart';
import 'package:namer_app/presentation/styles/my_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(options.baseUrl);
    return MaterialApp.router(
      title: 'Namer App',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.red, displayColor: Colors.white)),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class ScreenConfiguration {
  const ScreenConfiguration({
    required this.title,
  });

  final String title;
}

const configs = <int, ScreenConfiguration>{
  -1: ScreenConfiguration(title: 'NO-TITLE'),
  0: ScreenConfiguration(title: 'Nueva Sesión'),
  1: ScreenConfiguration(title: 'Historial'),
  2: ScreenConfiguration(title: 'Ejercicios'),
};

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = AddSessionScreen();
      case 1:
        page = HistoryScreen();
      case 2:
        page = ExercisesScreen();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    print(options.baseUrl);
    // ScreenConfiguration config = configs[selectedIndex] ?? configs[-1]!;
    // var screenTitle = config.title;

    return CoreConfigScreen();
    // return LayoutBuilder(builder: (context, constraints) {
    //   return Scaffold(
    //     body: Row(
    //       mainAxisSize: MainAxisSize.max,
    //       children: [
    //         NavigationRail(
    //           extended: constraints.maxWidth >= 600,
    //           destinations: [
    //             const NavigationRailDestination(
    //               icon: Icon(Icons.fitness_center),
    //               label: Text('Home'),
    //             ),
    //             const NavigationRailDestination(
    //               icon: Icon(Icons.history),
    //               label: Text('Favorites'),
    //             ),
    //             const NavigationRailDestination(
    //                 icon: Icon(Icons.settings), label: Text('Settings'))
    //           ],
    //           selectedIndex: selectedIndex,
    //           onDestinationSelected: (value) {
    //             setState(() {
    //               selectedIndex = value;
    //             });
    //             print('selected: $value');
    //           },
    //         ),
    //         Expanded(
    //           child: Container(
    //             padding: EdgeInsets.only(top: 10),
    //             margin: EdgeInsets.only(top: 24),
    //             color: MyColors.bg,
    //             child: page,
    //           ),
    //         ),
    //       ],
    //     ),
    //     // bottomNavigationBar: NavigationBar(destinations: destinations),
    //   );
    // });
  }
}
