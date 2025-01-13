import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:daytaskapp/data/models/task_model.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';
import 'package:daytaskapp/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskRepoImpl implements TaskRepo {
  final ApiService apiService;

  TaskRepoImpl({required this.apiService});

  @override
  Future<TaskResponse> fetchTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      String url = ApiPath.v1 + ApiPath.tasklist;
      final response = await apiService.get(path:'${url}/${userId}');

      if (response.statusCode == 200) {
        return TaskResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }
}
