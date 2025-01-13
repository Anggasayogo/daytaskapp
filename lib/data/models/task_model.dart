class TaskResponse {
  final bool status;
  final String message;
  final List<Task> data;

  TaskResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Parse JSON to Dart object
  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      status: json['status'] ?? false, // Default false if null
      message: json['message'] ?? '',  // Default empty string if null
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => Task.fromJson(item))
              .toList() ??
          [], // Default empty list if null
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class Task {
  final int id;
  final String taskName;
  final String taskProgres;
  final DateTime taskDate;
  final DateTime taskDueDate;
  final String taskDocs;
  final String username;
  final String email;
  final int point;
  final String priority;

  Task({
    required this.id,
    required this.taskName,
    required this.taskProgres,
    required this.taskDate,
    required this.taskDueDate,
    required this.taskDocs,
    required this.username,
    required this.email,
    required this.point,
    required this.priority,
  });

  // Parse JSON to Dart object
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int, // Cast to int
      taskName: json['task_name'] as String, // Cast to String
      taskProgres: json['task_progres'] as String, // Cast to String
      taskDate: DateTime.parse(json['task_date'] as String), // Convert to DateTime
      taskDueDate: DateTime.parse(json['task_duedate'] as String), // Convert to DateTime
      taskDocs: json['task_docs'] as String, // Cast to String
      username: json['username'] as String, // Cast to String
      email: json['email'] as String, // Cast to String
      point: json['point'] as int, // Cast to int
      priority: json['priority'] as String, // Cast to String
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_name': taskName,
      'task_progres': taskProgres,
      'task_date': taskDate.toIso8601String(), // Convert to ISO8601 String
      'task_duedate': taskDueDate.toIso8601String(), // Convert to ISO8601 String
      'task_docs': taskDocs,
      'username': username,
      'email': email,
      'point': point,
      'priority': priority,
    };
  }
}
