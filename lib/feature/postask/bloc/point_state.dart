part of 'point_bloc.dart';

abstract class PointState extends Equatable {
  const PointState();

  @override
  List<Object> get props => [];
}

class PointInitialState extends PointState {}

class PointLoadingState extends PointState {}

class PointLoadedState extends PointState {
  final PointListResponse pointListResponse;

  const PointLoadedState(this.pointListResponse);

  @override
  List<Object> get props => [pointListResponse];
}

class PointErrorState extends PointState {
  final String errorMessage;

  const PointErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
