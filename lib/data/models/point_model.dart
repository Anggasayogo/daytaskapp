class PointListResponse {
  final bool status;
  final String message;
  final List<Point> points;

  PointListResponse({
    required this.status,
    required this.message,
    required this.points,
  });

  // Factory constructor untuk parsing JSON ke objek
  factory PointListResponse.fromJson(Map<String, dynamic> json) {
    // Mengonversi JSON menjadi List<Point> dari bagian 'data'
    var list = json['data'] as List;
    List<Point> pointsList = list.map((i) => Point.fromJson(i)).toList();

    return PointListResponse(
      status: json['status'],
      message: json['message'],
      points: pointsList,
    );
  }
}

class Point {
  final int idPoint;
  final int point;
  final DateTime createdAt;
  final DateTime updatedAt;

  Point({
    required this.idPoint,
    required this.point,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor untuk parsing JSON ke objek Point
  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      idPoint: json['id_point'],
      point: json['point'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
