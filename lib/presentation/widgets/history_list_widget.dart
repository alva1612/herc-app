import 'package:flutter/material.dart';
import 'package:namer_app/domain/entities/training_session.dart';
import 'package:namer_app/domain/entities/training_session_set.dart';
import 'package:namer_app/presentation/styles/my_colors.dart';

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
            children: [Expanded(child: HistorySetRow(set: set))],
          )
      ],
    );
  }
}

class SessionHistoryList extends StatelessWidget {
  const SessionHistoryList({
    super.key,
    required this.sessions,
  });

  final List<TrainingSession> sessions;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        ...sessions.map((e) => HistorySessionCard(session: e,))
      ],
    );
  }
}

class HistorySessionCard extends StatelessWidget {
  final TrainingSession session;

  const HistorySessionCard({
    super.key,
    required this.session
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: DecoratedBox(
      decoration: BoxDecoration(color: MyColors.cardBg, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [Row(), ...session.trainingSets.map((set) => HistorySetRow(set: set,)
        )],
      ),
    ),
    );
  }
}

class HistorySetRow extends StatelessWidget {
  const HistorySetRow({
    super.key,
    required this.set,
  });

  final TrainingSessionSet set;

  @override
  Widget build(BuildContext context) {
    String volumeText = '${set.repetitions} x ${set.weight}';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(set.exercise.name ?? "", style: tHistoryExerciseTitle),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Text(
            volumeText,
            style: TextStyle(color: MyColors.textSecondary),
          ),
        ),
      ]),
    );
  }
}
