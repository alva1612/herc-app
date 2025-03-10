class Exercise {
  final String? uuid;
  final String? name;
  final String? description;

  Exercise({
    this.uuid,
    this.name, 
    this.description
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['description'] = description;
    return data;
  }

  factory Exercise.fromJsonMap(Map<String, dynamic> json) =>
    Exercise(
      uuid: json['uuid'], 
      name: json['name'], 
      description: json['description']
  );
}

class ExerciseCreateData {
  String? name;
  String? description;


  ExerciseCreateData({
    this.description,
    this.name,
  });

  setName(String n) {
    name = n;
  }

  setDescription(String desc) {
    description = desc;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}