part of 'task_detail_bloc.dart';

abstract class TaskDetailState extends Equatable {
  const TaskDetailState();

  @override
  List<Object?> get props => [];
}

class TaskDetailInitialState extends TaskDetailState {}

class TaskDetailLoadingState extends TaskDetailState {}

class TaskDetailSuccessState extends TaskDetailState {
  final TaskDetailData taskDetail;

  const TaskDetailSuccessState(this.taskDetail);

  @override
  List<Object?> get props => [taskDetail];
}

class TaskDetailErrorState extends TaskDetailState {
  final String message;

  const TaskDetailErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
