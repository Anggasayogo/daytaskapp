import 'package:daytaskapp/data/models/task_model.dart';

abstract class TaskRepo {
  Future<TaskResponse> fetchTasks();
}
