part of 'priority_bloc.dart';

abstract class PriorityEvent extends Equatable {
  const PriorityEvent();

  @override
  List<Object> get props => [];
}

class PriorityFetchEvent extends PriorityEvent {
  const PriorityFetchEvent();

  @override
  List<Object> get props => [];
}
