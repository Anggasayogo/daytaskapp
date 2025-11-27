class TaskDetailResponse {
  final bool status;
  final String message;
  final TaskDetailData data;

  TaskDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TaskDetailResponse.fromJson(Map<String, dynamic> json) {
    return TaskDetailResponse(
      status: json['status'],
      message: json['message'],
      data: TaskDetailData.fromJson(json['data']),
    );
  }
}

class TaskDetailData {
  final int id;
  final String taskName;
  final int id_pic;
  final int id_svp;
  final int id_point;
  final String taskProgres;
  final String taskDate;
  final String taskDueDate;
  final String taskDocs;
  final String username;
  final String email;
  final int point;
  final String priority;

  TaskDetailData({
    required this.id,
    required this.taskName,
    required this.id_pic,
    required this.id_svp,
    required this.id_point, 
    required this.taskProgres,
    required this.taskDate,
    required this.taskDueDate,
    required this.taskDocs,
    required this.username,
    required this.email,
    required this.point,
    required this.priority,
  });

  factory TaskDetailData.fromJson(Map<String, dynamic> json) {
    return TaskDetailData(
      id: json['id'],
      taskName: json['task_name'],
      id_pic: json['id_pic'],
      id_svp: json['id_svp'],
      id_point: json['id_point'],
      taskProgres: json['task_progres'],
      taskDate: json['task_date'],
      taskDueDate: json['task_duedate'],
      taskDocs: json['task_docs'],
      username: json['username'],
      email: json['email'],
      point: json['point'],
      priority: json['priority'],
    );
  }
}
