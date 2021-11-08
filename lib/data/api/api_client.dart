import 'package:dio/dio.dart';

class ApiClient {
  final String baseUrl = "https://api.stackexchange.com/2.3/";
  final int timeOut = 60000;

  Dio getApiClient() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      sendTimeout: timeOut,
    );
    // todo add headers
    // baseOptions.headers['header_name'] = header_value
    // add log interceptor
    var logInterceptor = LogInterceptor(requestBody: true, responseBody: true);
    // initialize dio client object
    var dio = Dio();
    dio.options = baseOptions;
    dio.interceptors.add(logInterceptor);

    return dio;
  }
}
