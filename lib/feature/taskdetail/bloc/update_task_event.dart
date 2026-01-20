part of 'update_task_bloc.dart';

abstract class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent();

  @override
  List<Object?> get props => [];
}

class UpdateTaskFetchEvent extends UpdateTaskEvent {
  final int idTask;
  final int idPoint;
  final String taskName;
  final String taskProgres;
  final String taskDate;
  final String taskDueDate;
  final String taskDocs;
  final String feedback;
  final int idPic;
  final int idSvp;

  const UpdateTaskFetchEvent({
    required this.idTask,
    required this.idPoint,
    required this.taskName,
    required this.taskProgres,
    required this.taskDate,
    required this.taskDueDate,
    required this.taskDocs,
    required this.feedback,
    required this.idPic,
    required this.idSvp,
  });

  @override
  List<Object?> get props => [
        idTask,
        idPoint,
        taskName,
        taskProgres,
        taskDate,
        taskDueDate,
        taskDocs,
        feedback,
        idPic,
        idSvp,
      ];
}
