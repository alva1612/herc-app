
import 'dart:convert';

import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/domain/entities/exercise.dart';

class ExerciseService {
  Future<bool> create(ExerciseCreateData exercise) async {
    try {
      var res = await client.post('exercise', data: jsonEncode(exercise));
      print(res);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}