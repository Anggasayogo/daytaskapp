class TaskData {
  final int idPoint;
  final String taskName;
  final String taskProgress;
  final String taskDate;
  final String taskDueDate;
  final String taskDocs;
  final int idPic;
  final int idSvp;

  TaskData({
    required this.idPoint,
    required this.taskName,
    required this.taskProgress,
    required this.taskDate,
    required this.taskDueDate,
    required this.taskDocs,
    required this.idPic,
    required this.idSvp,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      idPoint: json['id_point'],
      taskName: json['task_name'],
      taskProgress: json['task_progress'],
      taskDate: json['task_date'],
      taskDueDate: json['task_duedate'],
      taskDocs: json['task_docs'],
      idPic: json['id_pic'],
      idSvp: json['id_svp'],
    );
  }
}

class UpdateTaskResponse {
  final bool status;
  final String message;
  final List<TaskData> data;

  UpdateTaskResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateTaskResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<TaskData> taskList = list.map((i) => TaskData.fromJson(i)).toList();

    return UpdateTaskResponse(
      status: json['status'],
      message: json['message'],
      data: taskList,
    );
  }
}
