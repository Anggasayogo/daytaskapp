class UpdateTaskResponse {
  final bool status;
  final String message;
  final UpdateTaskData data;

  UpdateTaskResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateTaskResponse.fromJson(Map<String, dynamic> json) {
    return UpdateTaskResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: UpdateTaskData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class UpdateTaskData {
  final int idPoint;
  final String taskName;
  final String taskProgres;
  final String taskDate;
  final String taskDueDate;
  final String taskDocs;
  final String feedback;
  final int idPic;
  final int idSvp;

  UpdateTaskData({
    required this.idPoint,
    required this.taskName,
    required this.taskProgres,
    required this.taskDate,
    required this.taskDueDate,
    required this.taskDocs,
    required this.feedback,
    required this.idPic,
    required this.idSvp,
  });

  factory UpdateTaskData.fromJson(Map<String, dynamic> json) {
    return UpdateTaskData(
      idPoint: json['id_point'] as int,
      taskName: json['task_name'] as String,
      taskProgres: json['task_progres'] as String,
      taskDate: json['task_date'] as String,
      taskDueDate: json['task_duedate'] as String,
      taskDocs: json['task_docs'] as String,
      feedback: json['feedback'] as String,
      idPic: json['id_pic'] as int,
      idSvp: json['id_svp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_point': idPoint,
      'task_name': taskName,
      'task_progres': taskProgres,
      'task_date': taskDate,
      'task_duedate': taskDueDate,
      'task_docs': taskDocs,
      'feedback': feedback,
      'id_pic': idPic,
      'id_svp': idSvp,
    };
  }
}
