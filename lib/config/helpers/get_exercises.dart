import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/domain/entities/exercise.dart';

class GetExercises {

  Future<List<Exercise>> getExercises() async {
    final response = await client.get('exercise');


    final data = response.data['data'];
    return List<Exercise>.from(data.map((x) => Exercise.fromJsonMap(x)));
  }
}