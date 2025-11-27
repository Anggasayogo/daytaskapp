part of 'create_task_bloc.dart';

abstract class CreateTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateTaskInitialState extends CreateTaskState {}

class CreateTaskLoadingState extends CreateTaskState {}

class CreateTaskSuccessState extends CreateTaskState {
  final CreateTaskResponse response;

  CreateTaskSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class CreateTaskErrorState extends CreateTaskState {
  final String message;

  CreateTaskErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
