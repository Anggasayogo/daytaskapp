import 'package:daytaskapp/data/models/rangking_model.dart';
import 'package:daytaskapp/data/repo/rank/rank_repo.dart';
import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:daytaskapp/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankRepoImpl implements RankRepo {
  final ApiService apiService;

  RankRepoImpl({required this.apiService});

  @override
  Future<RankListResponse> fetchRanks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      String url = ApiPath.v1 + ApiPath.rank;

      final response = await apiService.get(path: url);

      print('API Response: ${response.statusCode}'); // Debugging: log status code
      print('API Response Data: ${response.data}'); // Debugging: log response data

      if (response.statusCode == 200) {
        return RankListResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load rank list');
      }
    } catch (e) {
      throw Exception('Error fetching ranks: $e');
    }
  }
}