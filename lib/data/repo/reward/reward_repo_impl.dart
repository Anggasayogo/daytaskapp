import 'package:daytaskapp/data/models/reward_voucher.dart';
import 'package:daytaskapp/data/repo/reward/reward_repo.dart';
import 'package:daytaskapp/data/services/api/api_service.dart';
import 'package:daytaskapp/utils/constants/api_path.dart';

class RewardRepoImpl implements RewardRepo {
  final ApiService apiService;

  RewardRepoImpl({required this.apiService});

  @override
  Future<List<RewardVoucher>> fetchRewards({
    required String userId,
  }) async {
    try {
      final url = '${ApiPath.v1}${ApiPath.reward}/$userId';

      final response = await apiService.get(path: url);

      if (response.statusCode == 200 &&
          response.data['status'] == true) {
        final List data = response.data['data'];

        return data
            .map((e) => RewardVoucher.fromJson(e))
            .toList();
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      throw Exception('Error fetching rewards: $e');
    }
  }
}
