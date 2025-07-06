
import 'dart:convert';

import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/domain/entities/exercise.dart';

class ExerciseService {
  static Future<bool> create(ExerciseCreateData exercise) async {
    try {
      final data = jsonEncode(exercise);
      print(data);
      var res = await client.post('exercise', data: data);
      print(res);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> delete(String uuid) async {
    try {
      print('Deleting exercise with UUID: $uuid');
      var res = await client.delete('exercise/$uuid');
      print(res);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
  
  static Future<List<Exercise>> getExercises() async {
    try {
      var res = await client.get('exercise');
      final data = res.data['data'];
      return List<Exercise>.from(data.map((x) => Exercise.fromJsonMap(x)));
    } catch (e) {
      print(e);
      return [];
    }
  }
}