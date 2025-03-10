
import 'package:flutter/material.dart';
import 'package:namer_app/domain/entities/training_session_set.dart';

class HistoryListWidget extends StatelessWidget {
  const HistoryListWidget({
    super.key,
    required this.sets,
  });

  final List<TrainingSessionSet> sets;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        for (var set in sets)
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [Expanded(child: HistoryRow(session: set))],
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

  final TrainingSessionSet session;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Text(session.exercise.name ?? "")),
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