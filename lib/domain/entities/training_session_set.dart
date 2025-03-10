import 'package:namer_app/domain/entities/exercise.dart';

class TrainingSessionSet {
  final DateTime dateRegistered;
  final String uuid;
  final String weight;
  final Exercise exercise;
  final int repetitions;

  TrainingSessionSet(
      {required this.dateRegistered,
      required this.uuid,
      required this.weight,
      required this.exercise,
      required this.repetitions});

  factory TrainingSessionSet.fromJsonMap(Map<String, dynamic> json) => TrainingSessionSet(
      dateRegistered: DateTime.parse(json['dateRegistered']),
      uuid: json['uuid'],
      weight: json['weight'],
      exercise: Exercise.fromJsonMap(json['exercise']),
      repetitions: json['repetitions']);
}

class TrainingSessionSetCreateData {
  double? weight;
  int? repetitions;
  Exercise? exercise;

  TrainingSessionSetCreateData({
    this.weight,
    this.repetitions,
    this.exercise,
  }) {
    exercise ??= Exercise();
  }

  setWeight(double w) {
    weight = w;
  }

  setReps(int r) {
    repetitions = r;
  }

  setExercise(Exercise ex) {
    exercise = ex;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weight'] = weight;
    data['repetitions'] = repetitions;
    if (exercise != null) {
      data['exercise'] = exercise!.toJson();
    }
    return data;
  }
}
