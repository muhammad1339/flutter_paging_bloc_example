import 'package:dio/dio.dart';
import 'package:untitled_flutter/data/data.dart';

class RemoteRepo {
  const RemoteRepo(this.apiService);
  final ApiService apiService;


  Future<Response<Map<String,dynamic>>> getStackAnswers({
    required String page,
    required String pageSize,
    required String query,
  }) async =>
     await apiService.getStackAnswers(page: page, pageSize: pageSize, query: query);

}