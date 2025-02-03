import 'package:flutter/material.dart';
import 'package:namer_app/config/helpers/get_sessions.dart';
import 'package:namer_app/domain/entities/temp_sessions.dart';
import 'package:provider/provider.dart';

class HistoryListState extends ChangeNotifier {}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryListState(),
      child: HistoryList(),
    );
  }
}

class HistoryList extends StatefulWidget {

  const HistoryList({
    super.key,
    this.listType
  });

  final String? listType;

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late Future<List<TempSession>> sessions;


  @override
  void initState() {
    super.initState();
    sessions = GetSessions().getSessions('today');
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
          return HistoryListView(sessions: snapshot.data!);
        });
  }
}

class HistoryListView extends StatelessWidget {
  const HistoryListView({
    super.key,
    required this.sessions,
  });

  final List<TempSession> sessions;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        for (var session in sessions)
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [Expanded(child: HistoryRow(session: session))],
          )
      ],
    );
  }
}

class HistoryRow extends StatelessWidget {
  const HistoryRow({
    super.key,
    required this.session,
  });

  final TempSession session;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Text(session.exercise.name)),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        width: 40,
        child: Text(session.weight.toString()),
      ),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: 40,
          child: Text(session.repetitions.toString()))
    ]);
  }
}
