
part of 'create_task_bloc.dart';

abstract class CreateTaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateTaskButtonPressed extends CreateTaskEvent {
  final int idPoint;
  final String taskName;
  final String taskProgres;
  final String taskDate;
  final String taskDueDate;
  final String taskDocs;
  final int idPic;
  final int idSvp;
  final int idPriority;

  CreateTaskButtonPressed({
    required this.taskName,
    required this.taskProgres,
    required this.taskDate,
    required this.taskDueDate,
    required this.taskDocs,
    required this.idPic,
    required this.idSvp,
    required this.idPriority,
    required this.idPoint
  });

  @override
  List<Object?> get props =>
      [taskName, taskProgres, taskDate, taskDueDate, taskDocs, idPic, idSvp, idPriority, idPoint];
}
