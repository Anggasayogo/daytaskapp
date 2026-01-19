import 'package:equatable/equatable.dart';

class RewardVoucher extends Equatable {
  final int idReward;
  final String title;
  final String rewardName;
  final String voucherCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RewardVoucher({
    required this.idReward,
    required this.title,
    required this.rewardName,
    required this.voucherCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RewardVoucher.fromJson(Map<String, dynamic> json) {
    return RewardVoucher(
      idReward: json['id_reward'],
      title: json['title'],
      rewardName: json['reward_name'],
      voucherCode: json['voucher_code'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  List<Object?> get props =>
      [idReward, title, rewardName, voucherCode, createdAt, updatedAt];
}
