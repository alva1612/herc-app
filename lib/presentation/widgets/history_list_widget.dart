
import 'package:flutter/material.dart';
import 'package:namer_app/domain/entities/temp_sessions.dart';

class HistoryListWidget extends StatelessWidget {
  const HistoryListWidget({
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