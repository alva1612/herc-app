
import 'dart:convert';

import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/domain/entities/exercise.dart';

class ExerciseService {
  Future<bool> create(ExerciseCreateData exercise) async {
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
}