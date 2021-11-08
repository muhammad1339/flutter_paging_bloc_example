import 'package:dio/dio.dart';

import '../data.dart';

class ApiService {
  const ApiService(this.apiClient);

  final ApiClient apiClient;

  Future<Response<Map<String, dynamic>>> getStackAnswers({
    required String page,
    required String pageSize,
    required String query,
  }) =>
      apiClient.getApiClient().get("answers", queryParameters: {
        'page': page,
        'pagesize': pageSize,
        'site': query,
      });
}
