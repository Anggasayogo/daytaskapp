import 'package:daytaskapp/data/models/task_model.dart';
// import 'package:daytaskapp/data/models/update_task_model.dart';

abstract class TaskRepo {
  Future<TaskResponse> fetchTasks({
    String? priority,
    String? taskProgress,
    String? filterDate,
    String? keyword,
  });
  // Future<UpdateTaskResponse> updateTask();
}
