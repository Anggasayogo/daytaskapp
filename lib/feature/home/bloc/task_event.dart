part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskFetchEvent extends TaskEvent {
  final String? priority;
  final String? taskProgress;
  final String? filterDate;
  final String? keyword;

  const TaskFetchEvent({this.priority, this.taskProgress, this.filterDate, this.keyword});

  @override
  List<Object> get props => [];
}
