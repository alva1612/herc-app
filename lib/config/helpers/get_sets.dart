import 'package:namer_app/config/http/client.dart';
import 'package:namer_app/domain/entities/training_session_set.dart';

class GetSets {
  Map<String, String> queryParams(String? customFilters) {
    if (customFilters == null) {
      return {};
    }
    Map<String, String> queryParams =
        Map.from({'customFilters': customFilters});
        return queryParams;
  }

  Future<List<TrainingSessionSet>> getSets(String? customFilters) async {
    var queryParams = this.queryParams(customFilters);
    print(queryParams.toString());
    final response = await client.get('session/set', queryParameters: queryParams);


    final data = response.data['data'];
    print('-----------GET-Sessions');
    print(data);
    return List<TrainingSessionSet>.from(data.map((x) => TrainingSessionSet.fromJsonMap(x)));
  }
}