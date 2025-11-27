import 'package:daytaskapp/data/models/create_task_model.dart';
import 'package:daytaskapp/data/models/taskDetail_model.dart';
import 'package:daytaskapp/data/models/task_model.dart';
import 'package:daytaskapp/data/models/update_task_model.dart';

abstract class TaskRepo {
  Future<TaskResponse> fetchTasks({
    String? priority,
    String? taskProgress,
    String? filterDate,
    String? keyword,
  });

  Future<void> downloadReport({
    required String id,
    String? start,
    String? end,
  });

  Future<TaskDetailResponse> fetchDetailTasks({
    String? id,
  });

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
  });

  Future<CreateTaskResponse> createTask({
    required int idPoint,
    required String taskName,
    required String taskProgres,
    required String taskDate,
    required String taskDueDate,
    required String taskDocs,
    required int idPic,
    required int idSvp,
    required int idPriority
  });
}
