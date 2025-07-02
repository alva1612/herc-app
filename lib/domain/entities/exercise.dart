class Exercise {
  final String? uuid;
  final String? name;
  final String? description;

  Exercise({this.uuid, this.name, this.description});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['description'] = description;
    return data;
  }

  factory Exercise.fromJsonMap(Map<String, dynamic> json) {
    print(json);
    return Exercise(
        uuid: json['uuid'],
        name: json['name'],
        description: json['description']);
  }
}

class MuscleExerciseOnCreate {
  String? muscleSectionId;
  int? effort;
  String? description;

  MuscleExerciseOnCreate({this.description, this.effort, this.muscleSectionId});

  setMuscleSectionId(String id) {
    muscleSectionId = id;
  }

  setEffort(int effortValue) {
    effort = effortValue;
  }

  setDescription(String desc) {
    description = desc;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['effort'] = effort;
    data['muscleSectionId'] = muscleSectionId;
    data['description'] = description;
    return data;
  }
}

class ExerciseCreateData {
  String? name;
  String? description;
  List<MuscleExerciseOnCreate> muscleSectionexercises;

  ExerciseCreateData(
      {this.description, this.name, this.muscleSectionexercises = const []});

  setName(String n) {
    name = n;
  }

  setDescription(String desc) {
    description = desc;
  }

  setMuscleExercises(List<MuscleExerciseOnCreate> newRelations) {
    print('--------------setMuscleExercises');
    print(muscleSectionexercises);
    muscleSectionexercises = newRelations;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    if (muscleSectionexercises.isEmpty) {
      data['muscleSectionExercises'] = [];
    } else {
      data['muscleSectionExercises'] =
          List<dynamic>.from(muscleSectionexercises.map((x) => x.toJson()));
    }
    return data;
  }
}
