import 'package:daytaskapp/data/models/reward_voucher.dart';

abstract class RewardRepo {
  Future<List<RewardVoucher>> fetchRewards({
    required String userId,
  });
}