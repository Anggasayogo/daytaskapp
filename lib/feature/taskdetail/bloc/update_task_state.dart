part of 'update_task_bloc.dart';

abstract class UpdateTaskState extends Equatable {
  const UpdateTaskState();

  @override
  List<Object?> get props => [];
}

class UpdateTaskInitialState extends UpdateTaskState {}

class UpdateTaskLoadingState extends UpdateTaskState {}

class UpdateTaskSuccessState extends UpdateTaskState {
  final String message;

  const UpdateTaskSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateTaskErrorState extends UpdateTaskState {
  final String message;

  const UpdateTaskErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
