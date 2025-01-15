import 'package:daytaskapp/data/models/update_task_model.dart';
import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:daytaskapp/data/models/task_model.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';
import 'package:daytaskapp/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskRepoImpl implements TaskRepo {
  final ApiService apiService;

  TaskRepoImpl({required this.apiService});

  @override
  Future<TaskResponse> fetchTasks({
    String? priority, 
    String? taskProgress,
    String? filterDate,
    String? keyword,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      if (userId == null) {
        throw Exception('User ID not found in shared preferences');
      }
      String url = ApiPath.v1 + ApiPath.tasklist;
      print("🔥 '$url?priority=$priority&task_progres=$taskProgress&filterDate=$filterDate&id=$userId'");
      final response = await apiService.get(path: '$url?priority=$priority&task_progres=$taskProgress&filterDate=$filterDate&keyword=$keyword&id=$userId');

      if (response.statusCode == 200) {
        return TaskResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  // @override
  // Future<TaskResponse> createTask({
  //   required String taskName,
  //   required String taskProgres,
  //   required String taskDate,
  //   required String taskDueDate,
  //   required String taskDocs,
  //   required int idPic,
  //   required int idSvp,
  // }) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final userId = prefs.getString('userId');
  //     if (userId == null) {
  //       throw Exception('User ID not found in shared preferences');
  //     }
  //     String url = ApiPath.v1 + ApiPath.tasklist;

  //     // Create a task with the provided data
  //     final Map<String, dynamic> data = {
  //       "user_id": userId,
  //       "task_name": taskName,
  //       "task_progres": taskProgres,
  //       "task_date": taskDate,
  //       "task_duedate": taskDueDate,
  //       "task_docs": taskDocs,
  //       "id_pic": idPic,
  //       "id_svp": idSvp,
  //     };

  //     final response = await apiService.post(path: url, data: data);

  //     if (response.statusCode == 200) {
  //       return TaskResponse.fromJson(response.data);
  //     } else {
  //       throw Exception('Failed to create task: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error creating task: $e');
  //   }
  // }

  // @override
  // Future<UpdateTaskResponse> updateTask({
  //   required int idTask,
  //   required int idPoint,
  //   required String taskName,
  //   required String taskProgres,
  //   required String taskDate,
  //   required String taskDueDate,
  //   required String taskDocs,
  //   required int idPic,
  //   required int idSvp,
  // }) async {
  //   try {
  //     String url = '${ApiPath.v1}${ApiPath.updateTask}';
  //     final Map<String, dynamic> data = {
  //       "id_task": idTask,
  //       "id_point": idPoint,
  //       "task_name": taskName,
  //       "task_progres": taskProgres,
  //       "task_date": taskDate,
  //       "task_duedate": taskDueDate,
  //       "task_docs": taskDocs,
  //       "id_pic": idPic,
  //       "id_svp": idSvp,
  //     };

  //     final response = await apiService.put(path: url, data: data);

  //     if (response.statusCode == 200) {
  //       return UpdateTaskResponse.fromJson(response.data);
  //     } else {
  //       throw Exception('Failed to update task: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error updating task: $e');
  //   }
  // }
}
