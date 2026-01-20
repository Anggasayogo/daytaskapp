import 'package:bloc/bloc.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';
import 'package:equatable/equatable.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  final TaskRepo taskRepo;

  UpdateTaskBloc({required this.taskRepo}) : super(UpdateTaskInitialState()) {
    on<UpdateTaskFetchEvent>(_onUpdateTask);
  }

  Future<void> _onUpdateTask(UpdateTaskFetchEvent event, Emitter<UpdateTaskState> emit) async {
    emit(UpdateTaskLoadingState());

    try {
      final updateResponse = await taskRepo.fetchUpdateTask(
        idTask: event.idTask,
        idPoint: event.idPoint,
        taskName: event.taskName,
        taskProgres: event.taskProgres,
        taskDate: event.taskDate,
        taskDueDate: event.taskDueDate,
        taskDocs: event.taskDocs,
        feedback: event.feedback,
        idPic: event.idPic,
        idSvp: event.idSvp,
      );
      print("🔥 ${updateResponse.status}");
      if (updateResponse.status) {
        emit(UpdateTaskSuccessState(updateResponse.message)); // Emit success state
      } else {
        emit(UpdateTaskErrorState('Failed to update task: ${updateResponse.message}')); // Emit error state
      }
    } catch (e) {
      emit(UpdateTaskErrorState('An error occurred: $e')); // Emit error state on exception
    }
  }
}
