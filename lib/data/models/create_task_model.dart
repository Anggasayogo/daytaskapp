class CreateTaskResponse {
  final bool status;
  final String message;
  final CreateTaskData data;

  CreateTaskResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateTaskResponse.fromJson(Map<String, dynamic> json) {
    return CreateTaskResponse(
      status: json['status'],
      message: json['message'],
      data: CreateTaskData.fromJson(json['data']),
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

class CreateTaskData {
  final int idPoint;
  final String taskName;
  final String taskProgres;
  final DateTime taskDate;
  final DateTime taskDueDate;
  final String taskDocs;
  final int idPic;
  final int idSvp;
  final int priorityId;

  CreateTaskData({
    required this.idPoint,
    required this.taskName,
    required this.taskProgres,
    required this.taskDate,
    required this.taskDueDate,
    required this.taskDocs,
    required this.idPic,
    required this.idSvp,
    required this.priorityId,
  });

  factory CreateTaskData.fromJson(Map<String, dynamic> json) {
    return CreateTaskData(
      idPoint: json['id_point'],
      taskName: json['task_name'],
      taskProgres: json['task_progres'],
      taskDate: DateTime.parse(json['task_date']),
      taskDueDate: DateTime.parse(json['task_duedate']),
      taskDocs: json['task_docs'],
      idPic: json['id_pic'],
      idSvp: json['id_svp'],
      priorityId: json['priority_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_point': idPoint,
      'task_name': taskName,
      'task_progres': taskProgres,
      'task_date': taskDate.toIso8601String(),
      'task_duedate': taskDueDate.toIso8601String(),
      'task_docs': taskDocs,
      'id_pic': idPic,
      'id_svp': idSvp,
      'priority_id': priorityId,
    };
  }
}
