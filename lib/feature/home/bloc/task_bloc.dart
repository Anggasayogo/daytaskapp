import 'package:bloc/bloc.dart';
import 'package:daytaskapp/data/models/task_model.dart';
import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepo taskRepo;

  TaskBloc({required this.taskRepo}) : super(TaskInitialState()) {
    on<TaskFetchEvent>(_onFetchTasks);
  }

  Future<void> _onFetchTasks(TaskFetchEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());

    try {
      // Panggil repositori untuk mengambil data tugas
      final taskResponse = await taskRepo.fetchTasks();

      if (taskResponse.status) {
        emit(TaskSuccessState(taskResponse.data)); // Emit TaskSuccessState jika data berhasil diambil
      } else {
        emit(TaskErrorState('Failed to fetch tasks: ${taskResponse.message}')); // Emit error state jika gagal
      }
    } catch (e) {
      emit(TaskErrorState('An error occurred: $e')); // Emit error state jika terjadi error
    }
  }
}
