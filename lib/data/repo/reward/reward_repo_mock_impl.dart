import 'package:daytaskapp/data/models/reward_voucher.dart';
import 'package:daytaskapp/data/repo/reward/reward_repo.dart';

class RewardRepoMockImpl implements RewardRepo {
  @override
  Future<List<RewardVoucher>> fetchRewards({required String userId}) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate API delay

    final mockResponse = {
      "status": true,
      "message": "Success get reward",
      "data": [
        {
          "id_reward": 3,
          "reward_name":
              "Voucher Belanja di Hypermart senilai Rp100.000 sudah termasuk PPN",
          "voucher_code": "HYPER-0012",
          "created_at": "2026-01-19T20:57:57.000Z",
          "updated_at": "2026-01-19T20:57:57.000Z"
        },
        {
          "id_reward": 4,
          "reward_name": "Voucher Makan di KFC Rp50.000",
          "voucher_code": "KFC-8899",
          "created_at": "2026-01-18T10:20:30.000Z",
          "updated_at": "2026-01-18T10:20:30.000Z"
        }
      ]
    };

    final List<dynamic> data = mockResponse['data'] as List<dynamic>;
    return data.map((e) => RewardVoucher.fromJson(e)).toList();
  }
}
