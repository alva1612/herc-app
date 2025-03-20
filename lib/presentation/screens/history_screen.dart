import 'package:flutter/material.dart';
import 'package:namer_app/config/helpers/get_sessions.dart';
import 'package:namer_app/domain/entities/training_session.dart';
import 'package:namer_app/presentation/widgets/history_list_widget.dart';
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
  });

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late Future<List<TrainingSession>> sessions;

  @override
  void initState() {
    super.initState();
    sessions = GetSessions().getSessions(null);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: sessions,
        builder: (contextFuture, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('error');
          }
          if (!snapshot.hasData) {
            return const Text('loading');
          }
          print('---SESSION GROUPS RAW');
          print(sessions);
          return SessionHistoryList(sessions: snapshot.data!);
        });
  }
}
