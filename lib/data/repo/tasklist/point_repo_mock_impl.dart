// priority_mock_impl.dart
import 'package:daytaskapp/data/models/point_model.dart';
import 'package:daytaskapp/data/repo/tasklist/point_repo.dart';

class PointRepoMockImpl implements PointRepo {
  @override
  Future<PointListResponse> fetchPointList() async {
    final mockResponse = {
      "status": true,
      "message": "Success get point list",
      "data": [
        {
          "id_point": 1,
          "point": 10,
          "createdAt": "2024-03-12T07:34:32.000Z",
          "updatedAt": "2024-03-12T07:34:32.000Z"
        },
        {
          "id_point": 2,
          "point": 20,
          "createdAt": "2024-03-12T07:34:32.000Z",
          "updatedAt": "2024-03-12T07:34:32.000Z"
        }
      ]
    };

    return PointListResponse.fromJson(mockResponse);
  }
}
