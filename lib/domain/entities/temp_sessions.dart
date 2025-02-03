import 'package:namer_app/domain/entities/exercise.dart';

class TempSession {
  final DateTime dateRegistered;
  final String uuid;
  final String weight;
  final Exercise exercise;
  final int repetitions;

  TempSession(
      {required this.dateRegistered,
      required this.uuid,
      required this.weight,
      required this.exercise,
      required this.repetitions});

  factory TempSession.fromJsonMap(Map<String, dynamic> json) => TempSession(
      dateRegistered: DateTime.parse(json['dateRegistered']),
      uuid: json['uuid'],
      weight: json['weight'],
      exercise: Exercise.fromJsonMap(json['exercise']),
      repetitions: json['repetitions']);
}

class TempSessionCreateData {
  double? weight;
  int? repetitions;
  String? exerciseUuid;

  TempSessionCreateData({
    this.weight,
    this.repetitions,
    this.exerciseUuid,
  });

  setWeight(double w) {
    weight = w;
  }

  setReps(int r) {
    repetitions = r;
  }

  setExercise(String ex) {
    exerciseUuid = ex;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weight'] = weight;
    data['repetitions'] = repetitions;
    data['exerciseUuid'] = exerciseUuid;
    return data;
  }
}
