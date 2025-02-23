import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/domain/entities/temp_sessions.dart';

class GetSessions {

  Map<String, String> queryParams(String? customFilters) {
    if (customFilters == null) {
      return {};
    }
    Map<String, String> queryParams =
        Map.from({'customFilters': customFilters});
        return queryParams;
  }

  Future<List<TempSession>> getSessions(String? customFilters) async {
    var queryParams = this.queryParams(customFilters);
    print(queryParams.toString());
    final response = await client.get('session', queryParameters: queryParams);

    final data = response.data['data'];
    return List<TempSession>.from(data.map((x) => TempSession.fromJsonMap(x)));
  }

  Future<TempSession?> getLastSessionByExercise(String exerciseUuid) async {
    try {
      final response = await client.get('session/last/$exerciseUuid');
      final data = response.data['data'];
      return TempSession.fromJsonMap(data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
