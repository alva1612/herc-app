class Exercise {
  final String? uuid;
  final String name;
  final String? description;

  Exercise({
    required this.uuid,
    required this.name, 
    this.description
  });

  factory Exercise.fromJsonMap(Map<String, dynamic> json) =>
    Exercise(
      uuid: json['uuid'], 
      name: json['name'], 
      description: json['description']
    );
}