import 'package:bloc/bloc.dart';
import 'package:daytaskapp/data/models/taskDetail_model.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';
import 'package:equatable/equatable.dart';

part 'task_detail_event.dart';
part 'task_detail_state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  final TaskRepo taskRepo;

  TaskDetailBloc({required this.taskRepo}) : super(TaskDetailInitialState()) {
    on<TaskDetailFetchEvent>(_onFetchTasks);
  }

  Future<void> _onFetchTasks(TaskDetailFetchEvent event, Emitter<TaskDetailState> emit) async {
    emit(TaskDetailLoadingState());

    try {
      final taskResponse = await taskRepo.fetchDetailTasks(
        id: event.taskId,
      );

      if (taskResponse.status) {
        emit(TaskDetailSuccessState(taskResponse.data)); 
      } else {
        emit(TaskDetailErrorState('Failed to fetch tasks: ${taskResponse.message}')); 
      }
    } catch (e) {
      emit(TaskDetailErrorState('An error occurred: $e')); 
    }
  }
}
