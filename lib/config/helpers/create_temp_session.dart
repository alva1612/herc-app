import 'dart:convert';
import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/domain/entities/training_session_set.dart';

class CreateTempSession {
  Future<bool> create(TrainingSessionSetCreateData session) async {
    try {
      var res = await client.post('session/set', data: jsonEncode(session));
      print(res);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}