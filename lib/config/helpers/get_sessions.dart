import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/domain/entities/temp_sessions.dart';

class GetSessions {

  Future<List<TempSession>> getSessions() async {
    final response = await client.get('session');
    
    final data = response.data['data'];
    return List<TempSession>.from(data.map((x) => TempSession.fromJsonMap(x)));
  }
}