import 'package:bloc/bloc.dart';
import 'package:daytaskapp/data/models/create_task_model.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';
import 'package:equatable/equatable.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  final TaskRepo taskRepo;

  CreateTaskBloc({required this.taskRepo})
      : super(CreateTaskInitialState()) {
    on<CreateTaskButtonPressed>(_onCreateTask);
  }

  Future<void> _onCreateTask(
      CreateTaskButtonPressed event, Emitter<CreateTaskState> emit) async {
    emit(CreateTaskLoadingState());

    try {
      final response = await taskRepo.createTask(
        idPoint: event.idPoint,
        taskName: event.taskName,
        taskProgres: event.taskProgres,
        taskDate: event.taskDate,
        taskDueDate: event.taskDueDate,
        taskDocs: event.taskDocs,
        idPic: event.idPic,
        idSvp: event.idSvp,
        idPriority: event.idPriority
      );

      emit(CreateTaskSuccessState(response));
    } catch (e) {
      emit(CreateTaskErrorState('Failed to create task: $e'));
    }
  }
}
