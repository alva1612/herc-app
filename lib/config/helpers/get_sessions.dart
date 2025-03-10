import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/domain/entities/training_session.dart';

class GetSessions {

  Map<String, String> queryParams(String? customFilters) {
    if (customFilters == null) {
      return {};
    }
    Map<String, String> queryParams =
        Map.from({'customFilters': customFilters});
        return queryParams;
  }

  Future<List<TrainingSession>> getSessions(String? customFilters) async {
    var queryParams = this.queryParams(customFilters);
    print(queryParams.toString());
    final response = await client.get('session', queryParameters: queryParams);

    final data = response.data['data'];
    return List<TrainingSession>.from(data.map((x) => TrainingSession.fromJsonMap(x)));
  }

  Future<TrainingSessionOverload?> getLastSessionByExercise(String exerciseUuid) async {
    try {
      final response = await client.get('session/last/$exerciseUuid');
      final data = response.data['data'];
      return TrainingSessionOverload.fromJsonMap(data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
