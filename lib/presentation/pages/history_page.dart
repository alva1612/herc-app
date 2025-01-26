
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/main.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // var favorites = appState.favorites;
    var sessions = appState.sessions;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        ListTile(
          title: Text('History: '),
        ),
        for (var session in sessions)
          // ListTile(
          //   leading: Icon(Icons.favorite) ,
          //   title: Text(session.exercise.name),
          //   onTap: () {
          //     // appState.toggleFavorite(pair: pair);
          //   },

          // ),
          Row(
            children: [
              Expanded(child: Text(session.exercise.name)),
              Container(
                padding: const EdgeInsets.all(5),
                width: 40,
                child: Text(session.weight.toString()),
              ),
              Container(
                  padding: const EdgeInsets.all(5),
                  width: 40,
                  child: Text(session.repetitions.toString()))
            ],
          )
      ],
    );
  }
}
