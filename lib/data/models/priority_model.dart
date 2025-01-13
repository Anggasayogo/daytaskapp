class PriorityResponse {
  final bool status;
  final String message;
  final List<PriorityData> data;

  PriorityResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Parse JSON to Dart object
  factory PriorityResponse.fromJson(Map<String, dynamic> json) {
    return PriorityResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((item) => PriorityData.fromJson(item))
          .toList(),
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

class PriorityData {
  final int idPriority;
  final String priorityName;
  final DateTime createdAt;
  final DateTime? updatedAt;

  PriorityData({
    required this.idPriority,
    required this.priorityName,
    required this.createdAt,
    this.updatedAt,
  });

  // Parse JSON to Dart object
  factory PriorityData.fromJson(Map<String, dynamic> json) {
    return PriorityData(
      idPriority: json['id_priority'],
      priorityName: json['priority_name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_priority': idPriority,
      'priority_name': priorityName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
