import 'package:equatable/equatable.dart';
import 'package:daytaskapp/data/models/reward_voucher.dart';

abstract class RewardState extends Equatable {
  const RewardState();

  @override
  List<Object?> get props => [];
}

class RewardInitial extends RewardState {}

class RewardLoading extends RewardState {}

class RewardLoaded extends RewardState {
  final List<RewardVoucher> rewards;

  const RewardLoaded(this.rewards);

  @override
  List<Object?> get props => [rewards];
}

class RewardError extends RewardState {
  final String message;

  const RewardError(this.message);

  @override
  List<Object?> get props => [message];
}
