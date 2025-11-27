// priority_impl.dart
import 'package:daytaskapp/data/models/point_model.dart';
import 'package:daytaskapp/data/repo/tasklist/point_repo.dart';
import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:daytaskapp/utils/constants/api_path.dart';

class PointRepoImpl implements PointRepo {
  final ApiService apiService;

  PointRepoImpl({required this.apiService});

  @override
  Future<PointListResponse> fetchPointList() async {
    String url = ApiPath.v1 + ApiPath.pointList;
    final response = await apiService.get(path: url);

     if (response.data is Map<String, dynamic>) {
      return PointListResponse.fromJson(response.data);
    } else {
      throw Exception('Unexpected response format');
    }
  }
}