part of 'rank_bloc.dart';

abstract class RankState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RankInitialState extends RankState {}

class RankLoadingState extends RankState {}

class RankSuccessState extends RankState {
  final List<RankData> ranks;

  RankSuccessState(this.ranks);

  @override
  List<Object?> get props => [ranks];
}

class RankErrorState extends RankState {
  final String message;

  RankErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
