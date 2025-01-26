import 'dart:convert';
import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/domain/entities/temp_sessions.dart';

class CreateTempSession {
  Future<bool> create(TempSessionCreateData session) async {
    try {
      var res = await client.post('session', data: jsonEncode(session));
      print(res);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}