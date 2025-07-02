// To parse this JSON data, do
//
//     final muscleSection = muscleSectionFromJson(jsonString);

import 'dart:convert';

import 'package:namer_app/config/http/client.dart';

List<MuscleSection> muscleSectionFromJson(String str) => List<MuscleSection>.from(json.decode(str).map((x) => MuscleSection.fromJson(x)));

String muscleSectionToJson(List<MuscleSection> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MuscleSectionExercise {
    MuscleSection exercise;
    int effort;
    String description;

    MuscleSectionExercise({
        required this.exercise,
        required this.effort,
        required this.description,
    });

    factory MuscleSectionExercise.fromJson(Map<String, dynamic> json) => MuscleSectionExercise(
        exercise: MuscleSection.fromJson(json["exercise"]),
        effort: json["effort"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "exercise": exercise.toJson(),
        "effort": effort,
        "description": description,
    };
}

class MuscleSection {
    String uuid;
    String name;
    String? description;
    List<MuscleSectionExercise>? muscleSectionExercises;

    MuscleSection({
        required this.uuid,
        required this.name,
        required this.description,
        this.muscleSectionExercises,
    });

    factory MuscleSection.fromJson(Map<String, dynamic> json) => MuscleSection(
        uuid: json["uuid"],
        name: json["name"],
        description: json["description"],
        muscleSectionExercises: json["muscleSectionExercises"] == null ? [] : List<MuscleSectionExercise>.from(json["muscleSectionExercises"]!.map((x) => MuscleSectionExercise.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "description": description,
        "muscleSectionExercises": muscleSectionExercises == null ? [] : List<dynamic>.from(muscleSectionExercises!.map((x) => x.toJson())),
    };
}

class MuscleSectionService {
  static Future<List<MuscleSection>> getMuscleSections(String expand) async {
    final response = await client.get('muscle');
    final data = response.data['data'];

    print('---------------------GETMUSCLE_SECTIONS');
    print(data);
    return List<MuscleSection>.from(data.map((x) => MuscleSection.fromJson(x)));
  }
}