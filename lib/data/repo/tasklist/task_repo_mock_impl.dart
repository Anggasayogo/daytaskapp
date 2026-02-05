import 'package:daytaskapp/data/models/create_task_model.dart';
import 'package:daytaskapp/data/models/taskDetail_model.dart';
import 'package:daytaskapp/data/models/task_model.dart';
import 'package:daytaskapp/data/models/update_task_model.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';

class TaskRepoMockImpl implements TaskRepo {
  
  @override
  Future<TaskResponse> fetchTasks({
    String? priority, 
    String? taskProgress, 
    String? filterDate,
    String? keyword,
  }) async {
    await Future.delayed(Duration(seconds: 2)); 
    return TaskResponse(
      status: true,
      message: 'success',
      data: [
        Task(
          id: 17,
          taskName: 'Buat Web MF yang keren 2',
          taskProgres: 'asign',
          taskDate: DateTime.parse('2024-07-09T01:30:00.000Z'),
          taskDueDate: DateTime.parse('2024-10-09T10:30:00.000Z'),
          taskDocs: 'docs.pdf',
          username: 'Angga Maul',
          email: 'anggasayogosm@gmail.com',
          point: 20,
          priority: 'HIGH',
        ),
      ],
    );
  }

  @override
  Future<TaskDetailResponse> fetchDetailTasks({
    String? id,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    // Mengembalikan response mock
    return TaskDetailResponse(
      status: true,
      message: 'Success Get Detail Task',
      data: TaskDetailData(
        id: 31,
        taskName: "Create Ui for Dashboard & Mobile App",
        id_pic: 10,
        id_svp: 11,
        id_point: 10,
        taskProgres: "asign",
        taskDate: DateTime.parse("2025-01-17T01:30:00.000Z").toIso8601String(), // Convert DateTime ke String
        taskDueDate: DateTime.parse("2024-01-18T10:30:00.000Z").toIso8601String(), // Convert DateTime ke String
        taskDocs: "docs.pdf",
        feedback: 'revisi',
        username: "Angga Maul",
        svp_name: 'Azky',
        email: "anggasayogosm@gmail.com",
        point: 10,
        priority: "LOW",
      ),
    );
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
    required String feedback,
    required int idPic,
    required int idSvp,
  }) async {
    // Mock response for testing
    return UpdateTaskResponse(
      status: true,
      message: "Task updated successfully",
      data: UpdateTaskData(
        idPoint: idPoint,
        taskName: taskName,
        taskProgres: taskProgres,
        taskDate: taskDate,
        taskDueDate: taskDueDate,
        taskDocs: taskDocs,
        feedback: feedback,
        idPic: idPic,
        idSvp: idSvp,
      ),
    );
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
    required int idPriority
  }) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock response data
    final mockResponse = {
      "status": true,
      "message": "Task created successfully",
      "data": {
        "id_point": 1,
        "task_name": taskName,
        "task_progres": taskProgres,
        "task_date": taskDate,
        "task_duedate": taskDueDate,
        "task_docs": taskDocs,
        "id_pic": idPic,
        "id_svp": idSvp,
        "priority_id": 1,
      }
    };

    // Simulate a successful response
    return CreateTaskResponse.fromJson(mockResponse);
  }

  @override
  Future<void> downloadReport({
    required String id,
    String? start,
    String? end,
  }) async {

  }

}
