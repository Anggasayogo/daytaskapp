import 'package:bloc/bloc.dart';
import 'package:daytaskapp/data/models/rangking_model.dart';
import 'package:daytaskapp/data/repo/rank/rank_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:daytaskapp/utils/exceptions/exceptions.dart';

part 'rank_event.dart';
part 'rank_state.dart';

class RankBloc extends Bloc<RankEvent, RankState> {
  final RankRepo rankRepo;

  RankBloc({required this.rankRepo}) : super(RankInitialState()) {
    on<RankFetchEvent>((event, emit) async {
      emit(RankLoadingState());

      try {
        final rankResponse = await rankRepo.fetchRanks();

        if (rankResponse.status) {
          emit(RankSuccessState(rankResponse.data));
        } else {
          emit(RankErrorState("Login failed: ${rankResponse.message}"));
        }
      } on RepoException catch (e) {
        emit(RankErrorState("Error while logging in: ${e.message}"));
      } catch (e) {
        emit(RankErrorState("An unexpected error occurred: ${e.toString()}"));
      }
    });
  }
}
