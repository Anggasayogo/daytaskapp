import 'package:daytaskapp/data/models/task_model.dart';
import 'package:daytaskapp/data/models/update_task_model.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';

class TaskRepoMockImpl implements TaskRepo {
  
  @override
  Future<TaskResponse> fetchTasks({
    String? priority, // Parameter opsional untuk prioritas
    String? taskProgress, // Parameter opsional untuk progress tugas
    String? filterDate,
    String? keyword,
  }) async {
    // Simulasi data mock untuk testing
    await Future.delayed(Duration(seconds: 2)); // Simulasi loading delay
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
        Task(
          id: 18,
          taskName: 'Buat Web MF yang keren 3',
          taskProgres: 'asign',
          taskDate: DateTime.parse('2024-07-09T01:30:00.000Z'),
          taskDueDate: DateTime.parse('2024-10-09T10:30:00.000Z'),
          taskDocs: 'docs.pdf',
          username: 'Angga Maul',
          email: 'anggasayogosm@gmail.com',
          point: 20,
          priority: 'HIGH',
        ),
        Task(
          id: 19,
          taskName: 'Buat Web MF yang keren 4',
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
  //   // Simulasi loading delay
  //   await Future.delayed(Duration(seconds: 2));

  //   return UpdateTaskResponse(
  //     status: true,
  //     message: "Success",
  //     data: [
  //       TaskData(
  //         idPoint: idPoint,
  //         taskName: taskName,
  //         taskProgress: taskProgres,
  //         taskDate: taskDate,  // Jika menggunakan DateTime, konversi dengan toIso8601String() atau format yang sesuai
  //         taskDueDate: taskDueDate, // Sama seperti taskDate
  //         taskDocs: taskDocs,
  //         idPic: idPic,
  //         idSvp: idSvp,
  //       ),
  //     ],
  //   );
  // }
}
