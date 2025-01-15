// import 'package:bloc/bloc.dart';
// import 'package:daytaskapp/data/repo/tasklist/task_repo.dart';

// part 'update_task_event.dart';
// part 'update_task_state.dart';

// class TaskUpdateBloc extends Bloc<Update, UpdateTaskState> {
//   final TaskRepo taskRepo;

//   TaskUpdateBloc({required this.taskRepo}) : super(UpdateTaskInitialState()) {
//     on<UpdateTaskFetchEvent>((event, emit) async {
//       emit(UpdateTaskLoadingState());

//       try {
//         final updateTaskResponse = await taskRepo.updateTask(
//           idTask: event.idTask,
//           idPoint: event.idPoint,
//           taskName: event.taskName,
//           taskProgres: event.taskProgres,
//           taskDate: event.taskDate,
//           taskDueDate: event.taskDueDate,
//           taskDocs: event.taskDocs,
//           idPic: event.idPic,
//           idSvp: event.idSvp,
//         );

//         if (updateTaskResponse.status) {
//           emit(UpdateTaskSuccessState(updateTaskResponse));
//         } else {
//           emit(UpdateTaskErrorState("Failed to update task: ${updateTaskResponse.message}"));
//         }
//       } on RepoException catch (e) {
//         emit(UpdateTaskErrorState("Error updating task: ${e.message}"));
//       } catch (e) {
//         emit(UpdateTaskErrorState("An unexpected error occurred: ${e.toString()}"));
//       }
//     });
//   }
// }
