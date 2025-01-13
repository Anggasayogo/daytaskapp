// priority_impl.dart
import 'dart:convert';
import 'package:daytaskapp/data/models/priority_model.dart';
import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:daytaskapp/utils/constants/api_path.dart';
import 'package:http/http.dart' as http;
import 'priority_repo.dart';

class PriorityRepoImpl implements PriorityRepo {
  final ApiService apiService;

  PriorityRepoImpl({required this.apiService});

  @override
  Future<PriorityResponse> fetchPriorities() async {
    String url = ApiPath.v1 + ApiPath.priority;
    final response = await apiService.get(path: url);

     if (response.data is Map<String, dynamic>) {
      return PriorityResponse.fromJson(response.data);
    } else {
      throw Exception('Unexpected response format');
    }
  }
  

  @override
  Future<void> addPriority(PriorityData priorityData) async {
    final response = await http.post(
      Uri.parse('priorities'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(priorityData.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add priority');
    }
  }

  @override
  Future<void> deletePriority(int idPriority) async {
    final response = await http.delete(Uri.parse('priorities'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete priority');
    }
  }
}