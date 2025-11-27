part of 'task_detail_bloc.dart';

abstract class TaskDetailEvent extends Equatable {
  const TaskDetailEvent();

  @override
  List<Object> get props => [];
}

class TaskDetailFetchEvent extends TaskDetailEvent {
  final String taskId;

  const TaskDetailFetchEvent({required this.taskId});

  @override
  List<Object> get props => [taskId];
}
