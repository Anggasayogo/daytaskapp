class RankListResponse {
  final bool status;
  final String message;
  final List<RankData> data;

  RankListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Parse JSON to Dart object
  factory RankListResponse.fromJson(Map<String, dynamic> json) {
    return RankListResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((item) => RankData.fromJson(item))
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

class RankData {
  final int userId;
  final String username;
  final String totalPoint;
  final int ranking;

  RankData({
    required this.userId,
    required this.username,
    required this.totalPoint,
    required this.ranking,
  });

  // Parse JSON to Dart object
  factory RankData.fromJson(Map<String, dynamic> json) {
    return RankData(
      userId: json['user_id'],
      username: json['username'],
      totalPoint: json['total_point'],
      ranking: json['ranking'],
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'total_point': totalPoint,
      'ranking': ranking,
    };
  }
}
