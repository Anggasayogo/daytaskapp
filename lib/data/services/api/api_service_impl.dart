import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../../models/api_response.dart';
import 'api_service.dart';

class ApiServiceImpl extends ApiService {
  late Dio _dio;

  @override
  void init({required String mainBaseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: mainBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    _dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );

    // Menambahkan interceptor untuk menambahkan token ke header
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Ambil token dari SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token'); // Ambil token yang disimpan

        // Jika token ada, tambahkan ke header
        if (token != null) {
          options.headers['Authorization'] = '$token';
        }

        return handler.next(options); // Melanjutkan request
      },
    ));

  }

  @override
  Future<ApiResponse> get({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: query);

      return ApiResponse.fromDioResponse(
        response,
      );
    } on DioException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse> post({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: query,
        data: data,
      );

      return ApiResponse.fromDioResponse(
        response,
      );
    } on DioException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse> put({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    try {
      final response = await _dio.put(
        path,
        queryParameters: query,
        data: data,
      );
  
      return ApiResponse.fromDioResponse(
        response,
      );
    } on DioException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

}
