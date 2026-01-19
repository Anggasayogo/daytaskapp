import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daytaskapp/data/repo/reward/reward_repo.dart';
import 'package:daytaskapp/data/repo/rank/rank_repo.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'reward_event.dart';
import 'reward_state.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final RewardRepo rewardRepo;
  final RankRepo rankRepo;

  RewardBloc({
    required this.rewardRepo,
    required this.rankRepo,
  }) : super(RewardInitial()) {
    on<FetchRewards>(_onFetchRewards);
  }

  Future<void> _onFetchRewards(
    FetchRewards event,
    Emitter<RewardState> emit,
  ) async {
    emit(RewardLoading());

    try {
      final userIdLogin = await getUserId();

      if (userIdLogin == null) {
        emit(const RewardError('User belum login'));
        return;
      }

      final rankList = await rankRepo.fetchRanks();

      final userRank = rankList.data.firstWhere(
        (e) => e.userId.toString() == userIdLogin,
        orElse: () => throw Exception('User tidak ada di ranking'),
      );

      print("USER_RANK"+userRank.ranking.toString());

      final rewards = await rewardRepo.fetchRewards(
        userId: userRank.ranking.toString(),
      );

      emit(RewardLoaded(rewards));
    } catch (e) {
      emit(RewardError(e.toString()));
    }
  }
}
