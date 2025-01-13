part of 'priority_bloc.dart';

abstract class PriorityState extends Equatable {
  const PriorityState();

  @override
  List<Object> get props => [];
}

class PriorityInitialState extends PriorityState {}

class PriorityLoadingState extends PriorityState {}

class PrioritySuccessState extends PriorityState {
  final List<PriorityData> priorities;

  const PrioritySuccessState(this.priorities);

  @override
  List<Object> get props => [priorities];
}

class PriorityErrorState extends PriorityState {
  final String message;

  const PriorityErrorState(this.message);

  @override
  List<Object> get props => [message];
}
