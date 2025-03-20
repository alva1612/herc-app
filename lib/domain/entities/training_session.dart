import 'package:namer_app/domain/entities/training_session_set.dart';

class TrainingSession {
  final String uuid;
  final DateTime dateStart;
  final dynamic dateEnd;
  final List<TrainingSessionSet> trainingSets;
  final DateTime dateRegistered;

  TrainingSession({
    required this.uuid,
    required this.dateStart,
    required this.dateEnd,
    required this.trainingSets,
    required this.dateRegistered,
  });

  factory TrainingSession.fromJsonMap(Map<String, dynamic> json) =>
      TrainingSession(
          uuid: json['uuid'],
          dateStart: DateTime.parse(json['dateStart']),
          dateEnd: json['dateEnd'],
          trainingSets: (json['trainingSets'] as List<dynamic>).map((e) => TrainingSessionSet.fromJsonMap(e)).toList(),
          dateRegistered: DateTime.parse(json['dateRegistered']));
}

class TrainingSessionCreateData {
  List<TrainingSessionSet>? trainingSets;
  List<String>? trainingSetUuids;

  TrainingSessionCreateData({
    this.trainingSetUuids,
    this.trainingSets,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (trainingSetUuids != null) {
      data['trainingSetUuids'] = trainingSetUuids;
    }
    if (trainingSets != null) {
      data['trainnigSets'] = trainingSets;
    }
    return data;
  }
}

class TrainingSessionOverload {
  String maxWeight;
  int maxReps;

  TrainingSessionOverload({required this.maxReps, required this.maxWeight});

  factory TrainingSessionOverload.fromJsonMap(Map<String, dynamic> json) =>
      TrainingSessionOverload(
          maxWeight: json['maxWeight'], maxReps: json['maxReps']);
}
