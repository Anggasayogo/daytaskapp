import '../../models/api_response.dart';

abstract class ApiService {
  void init({required String mainBaseUrl});

  Future<ApiResponse> get({required String path, Map<String, dynamic>? query});
  Future<ApiResponse> post({required String path,Map<String, dynamic>? query, dynamic data});
}
