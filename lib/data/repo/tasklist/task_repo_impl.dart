import 'dart:io';

import 'package:daytaskapp/data/models/create_task_model.dart';
import 'package:daytaskapp/data/models/taskDetail_model.dart';
import 'package:daytaskapp/data/models/update_task_model.dart';
import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:daytaskapp/data/models/task_model.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';
import 'package:daytaskapp/utils/constants/api_path.dart';
import 'package:path_provider/path_provider.dart';
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
      // Mendapatkan SharedPreferences instance
      final prefs = await SharedPreferences.getInstance();

      // Mendapatkan nilai userId dan roleId dengan nilai default jika null
      final String userId = prefs.getString('userId') ?? '';
      final String roleId = prefs.getString('roleId') ?? '';

      if (userId.isEmpty || roleId.isEmpty) {
        throw Exception('User ID or Role ID is missing in SharedPreferences');
      }

      // Menentukan parameter tambahan berdasarkan roleId
      final String type = roleId == '1' ? 'all' : '';
      final String isUserId = roleId == '2' ? userId : '';

      String url = ApiPath.v1 + ApiPath.tasklist;
      final response = await apiService.get(path: '$url?priority=$priority&task_progres=$taskProgress&filterDate=$filterDate&keyword=$keyword&id=$isUserId&type=$type');

      if (response.statusCode == 200) {
        return TaskResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  @override
  Future<TaskDetailResponse> fetchDetailTasks({
    String? id,
  }) async {
    try {
      String url = ApiPath.v1 + ApiPath.taskDetail;
      final response = await apiService.get(path: '$url/$id');

      if (response.statusCode == 200) {
        return TaskDetailResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  @override
  Future<void> downloadReport({
    required String id,
    String? start,
    String? end,
  }) async {
    try {
      String url = ApiPath.v1 + ApiPath.report;
      final response = await apiService.get(path: '$url/?id=$id&start=$start&end=$end');

      if (response.statusCode == 200) {
        // Simpan file ke perangkat
      final directory = await getApplicationCacheDirectory();
      final filePath = '${directory.path}/report.pdf';
      final file = File(filePath);

      await file.writeAsBytes(response.data);
      print('Laporan berhasil diunduh di $filePath');
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  @override
  Future<CreateTaskResponse> createTask({
     required int idPoint,
    required String taskName,
    required String taskProgres,
    required String taskDate,
    required String taskDueDate,
    required String taskDocs,
    required int idPic,
    required int idSvp,
    required int idPriority,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      
      if (userId == null) {
        throw Exception('User ID not found in shared preferences');
      }
      String url = ApiPath.v1 + ApiPath.craeteTasklist;

      // Create a task with the provided data
      final Map<String, dynamic> data = {
        "id_point": idPoint,
        "task_name": taskName,
        "task_progres": taskProgres,
        "task_date": taskDate,
        "task_duedate": taskDueDate,
        "task_docs": taskDocs,
        "id_pic": idPic,
        "id_svp": idSvp,
        "id_priority": idPriority
      };

      final response = await apiService.post(path: url, data: data);

      if (response.statusCode == 201) {
        return CreateTaskResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to create task: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating task: $e');
    }
  }

  @override
  Future<UpdateTaskResponse> fetchUpdateTask({
    required int idTask,
    required int idPoint,
    required String taskName,
    required String taskProgres,
    required String taskDate,
    required String taskDueDate,
    required String taskDocs,
    required int idPic,
    required int idSvp,
  }) async {
    try {
      String url = '${ApiPath.v1}${ApiPath.updateTask}';
      final Map<String, dynamic> data = {
        "id_task": idTask,
        "id_point": idPoint,
        "task_name": taskName,
        "task_progres": taskProgres,
        "task_date": taskDate,
        "task_duedate": taskDueDate,
        "task_docs": taskDocs,
        "id_pic": idPic,
        "id_svp": idSvp,
      };

      final response = await apiService.put(path: url, data: data);

      if (response.statusCode == 201) {
        return UpdateTaskResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to update task: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating task: $e');
    }
  }
}
